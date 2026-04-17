import 'generated/strings.g.dart';

/// Locale-prefixed routes (`/en`, `/en/projects`, …).
abstract final class AppPaths {
  static String home(AppLocale locale) => '/${locale.languageCode}';

  static String projects(AppLocale locale) => '/${locale.languageCode}/projects';

  static String contact(AppLocale locale) => '/${locale.languageCode}/contact';

  /// Same path with a different locale prefix (first segment).
  static String switchLocale(String currentLocation, AppLocale target) {
    final uri = Uri.parse(currentLocation);
    final parts = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) {
      return home(target);
    }
    parts[0] = target.languageCode;
    final path = '/${parts.join('/')}';
    if (uri.hasQuery) {
      return '$path?${uri.query}';
    }
    return path;
  }
}
