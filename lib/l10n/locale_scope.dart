import 'package:jaspr/jaspr.dart';

import 'generated/strings.g.dart';

/// Provides [AppLocale] and [AppLocalizations] to descendants (nav, pages, footer).
class LocaleScope extends InheritedComponent {
  const LocaleScope({
    required this.locale,
    required this.strings,
    required super.child,
    super.key,
  });

  final AppLocale locale;
  final AppLocalizations strings;

  static LocaleScopeData of(BuildContext context) {
    final scope = context.dependOnInheritedComponentOfExactType<LocaleScope>();
    if (scope == null) {
      throw StateError('LocaleScope not found in context');
    }
    return LocaleScopeData(locale: scope.locale, strings: scope.strings);
  }

  static LocaleScopeData? maybeOf(BuildContext context) {
    final scope = context.dependOnInheritedComponentOfExactType<LocaleScope>();
    if (scope == null) return null;
    return LocaleScopeData(locale: scope.locale, strings: scope.strings);
  }

  @override
  bool updateShouldNotify(covariant LocaleScope oldComponent) {
    return locale != oldComponent.locale;
  }
}

class LocaleScopeData {
  const LocaleScopeData({
    required this.locale,
    required this.strings,
  });

  final AppLocale locale;
  final AppLocalizations strings;
}
