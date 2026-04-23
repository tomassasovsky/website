import 'package:shelf/shelf.dart';

/// Serves a locale-aware sitemap for all public, indexable pages.
Middleware get sitemapMiddleware {
  return (Handler inner) {
    return (Request request) async {
      if (request.requestedUri.path != '/sitemap.xml') {
        return inner(request);
      }

      if (request.method != 'GET' && request.method != 'HEAD') {
        return Response(405, headers: const {'allow': 'GET, HEAD'});
      }

      final origin = _originFor(request);
      final lastmod = DateTime.now().toUtc().toIso8601String().split('T').first;

      const paths = <String>[
        '/en',
        '/en/projects',
        '/en/contact',
        '/es',
        '/es/projects',
        '/es/contact',
      ];

      final buffer = StringBuffer()
        ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
        ..writeln('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">');

      for (final path in paths) {
        buffer
          ..writeln('  <url>')
          ..writeln('    <loc>$origin$path</loc>')
          ..writeln('    <lastmod>$lastmod</lastmod>')
          ..writeln('  </url>');
      }

      buffer.writeln('</urlset>');

      return Response.ok(
        request.method == 'HEAD' ? '' : buffer.toString(),
        headers: const {'content-type': 'application/xml; charset=utf-8'},
      );
    };
  };
}

String _originFor(Request request) {
  final uri = request.requestedUri;
  final port = uri.hasPort && !((uri.scheme == 'https' && uri.port == 443) || (uri.scheme == 'http' && uri.port == 80))
      ? ':${uri.port}'
      : '';

  return '${uri.scheme}://${uri.host}$port';
}
