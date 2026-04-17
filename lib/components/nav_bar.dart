import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../data/site_data.dart';
import '../l10n/generated/strings.g.dart';
import '../l10n/locale_scope.dart';
import '../l10n/paths.dart';

class NavBar extends StatelessComponent {
  const NavBar({super.key});

  @override
  Component build(BuildContext context) {
    final l10n = LocaleScope.of(context);
    final path = _normalizedPath(RouteState.of(context).location);
    final locale = l10n.locale;
    final s = l10n.strings;

    final links = <({String href, String label})>[
      (href: AppPaths.home(locale), label: s.navAbout),
      (href: AppPaths.projects(locale), label: s.navProjects),
      (href: AppPaths.contact(locale), label: s.navContact),
    ];

    return nav(classes: 'navbar', [
      div(classes: 'container', [
        div(classes: 'navbar__inner', [
          Link(
            to: AppPaths.home(locale),
            classes: 'navbar__brand',
            children: [
              .text('${siteName.split(' ').first} '),
              span([.text(siteName.split(' ').last)]),
            ],
          ),
          ul(classes: 'navbar__links', [
            for (final item in links)
              li([
                Link(
                  to: item.href,
                  classes: 'navbar__link${_pathMatches(path, item.href) ? ' active' : ''}',
                  children: [.text(item.label)],
                ),
              ]),
          ]),
          div(
            classes: 'navbar__lang',
            attributes: {'title': s.langSwitchLabel},
            [
              _LangLink(
                label: s.langSwitchEnglish,
                targetLocale: AppLocale.en,
                currentLocale: locale,
                location: RouteState.of(context).location,
              ),
              .text(' · '),
              _LangLink(
                label: s.langSwitchSpanish,
                targetLocale: AppLocale.es,
                currentLocale: locale,
                location: RouteState.of(context).location,
              ),
            ],
          ),
        ]),
      ]),
    ]);
  }

  static String _normalizedPath(String location) {
    final p = Uri.parse(location).path;
    if (p.length > 1 && p.endsWith('/')) {
      return p.substring(0, p.length - 1);
    }
    return p.isEmpty ? '/' : p;
  }

  static bool _pathMatches(String current, String href) {
    final h = _normalizedPath(href);
    return current == h;
  }
}

class _LangLink extends StatelessComponent {
  const _LangLink({
    required this.label,
    required this.targetLocale,
    required this.currentLocale,
    required this.location,
  });

  final String label;
  final AppLocale targetLocale;
  final AppLocale currentLocale;
  final String location;

  @override
  Component build(BuildContext context) {
    final to = AppPaths.switchLocale(location, targetLocale);
    final active = targetLocale == currentLocale;
    return Link(
      to: to,
      classes: 'navbar__lang-link${active ? ' active' : ''}',
      children: [.text(label)],
    );
  }
}
