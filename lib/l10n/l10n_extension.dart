import 'package:jaspr/jaspr.dart';

import 'generated/strings.g.dart';
import 'locale_scope.dart';

extension L10nBuildContext on BuildContext {
  AppLocalizations get strings => LocaleScope.of(this).strings;

  AppLocale get locale => LocaleScope.of(this).locale;
}
