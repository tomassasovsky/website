import 'package:shelf/shelf.dart';

import '../l10n/generated/strings.g.dart';
import '../l10n/locale_codec.dart';

/// Redirects requests without a locale prefix to the locale inferred from the
/// [Accept-Language] request header, falling back to [AppLocale.en].
///
/// Only bare page requests are redirected (GET/HEAD, no file-extension, no
/// existing locale prefix, and the browser signals HTML acceptance).
Middleware get localeRedirectMiddleware {
  return (Handler inner) {
    return (Request request) async {
      if (request.method != 'GET' && request.method != 'HEAD') {
        return inner(request);
      }

      final path = request.requestedUri.path;
      final segments = path.split('/').where((s) => s.isNotEmpty).toList();

      // Already has a valid locale prefix – nothing to do.
      if (segments.isNotEmpty && localeFromPathSegment(segments.first) != null) {
        return inner(request);
      }

      // Skip static asset requests (paths with a file extension).
      final lastSegment = segments.isEmpty ? '' : segments.last;
      if (lastSegment.contains('.')) {
        return inner(request);
      }

      // Only redirect browser navigation (must accept text/html).
      final accept = request.headers['accept'] ?? '';
      if (!accept.contains('text/html')) {
        return inner(request);
      }

      final acceptLanguage = request.headers['accept-language'] ?? '';
      final locale = _parseAcceptLanguage(acceptLanguage);

      final newPath = segments.isEmpty ? '/${locale.languageCode}' : '/${locale.languageCode}/${segments.join('/')}';

      final query = request.requestedUri.hasQuery ? '?${request.requestedUri.query}' : '';
      return Response.found('$newPath$query');
    };
  };
}

/// Parses an [Accept-Language] header value and returns the best supported
/// [AppLocale], defaulting to [AppLocale.en].
///
/// Example header: `es-AR,es;q=0.9,en-US;q=0.8,en;q=0.7`
AppLocale _parseAcceptLanguage(String header) {
  if (header.isEmpty) return AppLocale.en;

  // Build a list of (languageCode, quality) pairs sorted by descending quality.
  final candidates = <(String lang, double q)>[];

  for (final part in header.split(',')) {
    final trimmed = part.trim();
    final qIndex = trimmed.indexOf(';');
    final tag = (qIndex >= 0 ? trimmed.substring(0, qIndex) : trimmed).trim().toLowerCase();
    double q = 1.0;
    if (qIndex >= 0) {
      final qPart = trimmed.substring(qIndex + 1).trim();
      if (qPart.startsWith('q=')) {
        q = double.tryParse(qPart.substring(2)) ?? 1.0;
      }
    }
    if (tag.isNotEmpty) {
      candidates.add((tag, q));
    }
  }

  candidates.sort((a, b) => b.$2.compareTo(a.$2));

  for (final (tag, _) in candidates) {
    // Try the primary language subtag (e.g. 'es' from 'es-ar').
    final code = tag.split('-').first;
    final locale = localeFromPathSegment(code);
    if (locale != null) return locale;
  }

  return AppLocale.en;
}
