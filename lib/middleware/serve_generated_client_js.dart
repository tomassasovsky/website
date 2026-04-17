import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';

/// Serves DDC / dart2js outputs when not using the `jaspr serve` proxy
/// ([JASPR_PROXY_PORT]).
///
/// 1. **`/packages/...`** — resolved with [PackageConfig] to pub-cache / generated
///    package roots (`require.js`, `stack_trace_mapper.dart.js`, …).
/// 2. **`/main.client*.js`** (and related maps) — from the build_runner `web` output
///    for this app.
///
/// Without this, `dart run lib/main.server.dart` returns plain-text 404 bodies for
/// those URLs and the browser blocks scripts (`X-Content-Type-Options: nosniff`).
Middleware get serveLocalDevWebAssets {
  return (Handler inner) {
    return (Request request) async {
      if (request.method != 'GET' && request.method != 'HEAD') {
        return inner(request);
      }
      final uriPath = request.requestedUri.path;

      if (uriPath.startsWith('/packages/')) {
        final fromPackages = await _tryServePackagePath(uriPath);
        if (fromPackages != null) {
          return fromPackages;
        }
      }

      if (uriPath.startsWith('/main.client')) {
        final fromWeb = _tryServeGeneratedWeb(uriPath);
        if (fromWeb != null) {
          return fromWeb;
        }
      }

      return inner(request);
    };
  };
}

final _generatedWebRoot = p.joinAll([
  Directory.current.path,
  '.dart_tool',
  'build',
  'generated',
  'website',
  'web',
]);

PackageConfig? _packageConfig;

Future<PackageConfig> _loadPackageConfig() async {
  _packageConfig ??= await loadPackageConfig(
    File(p.absolute(p.join(Directory.current.path, '.dart_tool', 'package_config.json'))),
  );
  return _packageConfig!;
}

Future<Response?> _tryServePackagePath(String uriPath) async {
  final rest = uriPath.substring('/packages/'.length);
  if (rest.isEmpty) return null;

  final config = await _loadPackageConfig();

  Uri? packageUri;
  try {
    packageUri = Uri.parse('package:$rest');
  } on FormatException {
    return null;
  }

  Uri? resolved;
  try {
    resolved = config.resolve(packageUri);
  } on ArgumentError {
    resolved = null;
  }
  if (resolved != null) {
    final fromPubCache = File.fromUri(resolved);
    if (fromPubCache.existsSync()) {
      return _fileResponse(fromPubCache, uriPath);
    }
  }

  // Some DDC assets (e.g. `require.js`) exist only under build_runner output, not in pub-cache.
  final segments = rest.split('/');
  if (segments.length >= 2) {
    final pkg = segments.first;
    final underLib = segments.sublist(1).join('/');
    final generated = File(
      p.join(
        Directory.current.path,
        '.dart_tool',
        'build',
        'generated',
        pkg,
        'lib',
        underLib,
      ),
    );
    if (generated.existsSync()) {
      return _fileResponse(generated, uriPath);
    }
  }
  return null;
}

Response? _tryServeGeneratedWeb(String uriPath) {
  if (!(uriPath.endsWith('.js') || uriPath.endsWith('.map') || uriPath.endsWith('.digests'))) {
    return null;
  }
  final name = p.basename(uriPath);
  final file = File(p.join(_generatedWebRoot, name));
  if (!file.existsSync()) return null;
  return _fileResponse(file, uriPath);
}

Response _fileResponse(File file, String uriPath) {
  return Response.ok(
    file.openRead(),
    headers: {
      'content-type': _contentTypeForPath(uriPath),
      'cache-control': 'no-cache',
    },
  );
}

String _contentTypeForPath(String uriPath) {
  if (uriPath.endsWith('.js')) {
    return 'application/javascript; charset=utf-8';
  }
  if (uriPath.endsWith('.map')) {
    return 'application/json; charset=utf-8';
  }
  return 'application/octet-stream';
}
