/// Generated file. Do not edit.
///
/// Source: lib/l10n/arb
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 316 (158 per locale)
///
/// Built on 2026-04-18 at 00:55 UTC

// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'package:slang/slang.dart';
export 'package:slang/slang.dart';

import 'strings_es.g.dart' as l_es;
part 'strings_en.g.dart';

/// Supported locales.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, AppLocalizations> {
  en(languageCode: 'en'),
  es(languageCode: 'es')
  ;

  const AppLocale({
    required this.languageCode,
    this.scriptCode, // ignore: unused_element, unused_element_parameter
    this.countryCode, // ignore: unused_element, unused_element_parameter
  });

  @override
  final String languageCode;
  @override
  final String? scriptCode;
  @override
  final String? countryCode;

  @override
  Future<AppLocalizations> build({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) async {
    return buildSync(
      overrides: overrides,
      cardinalResolver: cardinalResolver,
      ordinalResolver: ordinalResolver,
    );
  }

  @override
  AppLocalizations buildSync({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) {
    switch (this) {
      case AppLocale.en:
        return AppLocalizationsEn(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
      case AppLocale.es:
        return l_es.AppLocalizationsEs(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
    }
  }

  /// Gets current instance managed by [LocaleSettings].
  AppLocalizations get translations => LocaleSettings.instance.getTranslations(this);
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of strings).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = strings.someKey.anotherKey;
/// String b = strings['someKey.anotherKey']; // Only for edge cases!
AppLocalizations get strings => LocaleSettings.instance.currentTranslations;

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseLocaleSettings<AppLocale, AppLocalizations> {
  LocaleSettings._()
    : super(
        utils: AppLocaleUtils.instance,
        lazy: false,
      );

  static final instance = LocaleSettings._();

  // static aliases (checkout base methods for documentation)
  static AppLocale get currentLocale => instance.currentLocale;
  static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
  static Future<AppLocale> setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) =>
      instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
  static Future<AppLocale> setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) =>
      instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
  static Future<void> setPluralResolver({
    String? language,
    AppLocale? locale,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) => instance.setPluralResolver(
    language: language,
    locale: locale,
    cardinalResolver: cardinalResolver,
    ordinalResolver: ordinalResolver,
  );

  // synchronous versions
  static AppLocale setLocaleSync(AppLocale locale, {bool? listenToDeviceLocale = false}) =>
      instance.setLocaleSync(locale, listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale setLocaleRawSync(String rawLocale, {bool? listenToDeviceLocale = false}) =>
      instance.setLocaleRawSync(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
  static void setPluralResolverSync({
    String? language,
    AppLocale? locale,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) => instance.setPluralResolverSync(
    language: language,
    locale: locale,
    cardinalResolver: cardinalResolver,
    ordinalResolver: ordinalResolver,
  );
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, AppLocalizations> {
  AppLocaleUtils._()
    : super(
        baseLocale: AppLocale.en,
        locales: AppLocale.values,
      );

  static final instance = AppLocaleUtils._();

  // static aliases (checkout base methods for documentation)
  static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
  static AppLocale parseLocaleParts({
    required String languageCode,
    String? scriptCode,
    String? countryCode,
  }) => instance.parseLocaleParts(
    languageCode: languageCode,
    scriptCode: scriptCode,
    countryCode: countryCode,
  );
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}
