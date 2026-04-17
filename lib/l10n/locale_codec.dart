import 'generated/strings.g.dart';

/// Resolves `/en` / `/es` URL segments to [AppLocale] (slang-generated enum).
AppLocale? localeFromPathSegment(String? segment) {
  if (segment == null) return null;
  for (final locale in AppLocale.values) {
    if (locale.languageCode == segment) return locale;
  }
  return null;
}
