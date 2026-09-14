import 'dart:io';

import 'package:jaspr/server.dart';

/// Give each compiled client and its deferred chunks a fresh URL per build.
/// Unversioned JavaScript can otherwise survive a deployment in browser caches.
ServerOptions versionClientAssets(ServerOptions options) {
  final clientId = options.clientId;
  if (kDebugMode || clientId == null) return options;

  final asset = File.fromUri(Platform.script.resolve('web/$clientId'));
  if (!asset.existsSync()) return options;

  final version = asset.lastModifiedSync().microsecondsSinceEpoch.toRadixString(36);
  final prefix = '_client/$version/';
  ServerApp.addMiddleware((inner) {
    return (request) {
      if (request.url.path.startsWith(prefix)) {
        return inner(request.change(path: prefix));
      }
      return inner(request);
    };
  });

  return ServerOptions(
    clientId: '$prefix$clientId',
    clients: options.clients,
    stylesId: options.stylesId,
    styles: options.styles,
  );
}
