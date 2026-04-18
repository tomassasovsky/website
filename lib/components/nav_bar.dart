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

    final onHome = _pathMatches(path, AppPaths.home(locale));

    final langLinks = <Component>[
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
    ];

    return nav(classes: 'navbar${onHome ? '' : ' navbar--scrolled'}', [
      div(classes: 'container', [
        // Hidden checkbox — CSS-only mobile menu toggle
        input(type: InputType.checkbox, id: 'nav-toggle', classes: 'nav-toggle'),
        div(classes: 'navbar__inner', [
          Link(
            to: AppPaths.home(locale),
            classes: 'navbar__brand',
            children: [
              img(src: siteAvatar, alt: siteName, classes: 'navbar__avatar'),
              .text(siteName),
            ],
          ),
          ul(classes: 'navbar__links', [
            for (final item in links)
              li([
                Link(
                  to: item.href,
                  classes: 'navbar__link${_pathMatches(path, item.href) ? ' active' : ''}',
                  children: [.text(item.label)],
                  styles: item == links.last ? null : Styles(margin: Spacing.symmetric(horizontal: 0.5.em)),
                ),
              ]),
          ]),
          div(classes: 'navbar__right', [
            button(
              classes: 'theme-toggle',
              attributes: const {
                'onclick': 'window.toggleTheme(this)',
                'title': 'Toggle theme',
                'type': 'button',
              },
              [div(id: 'theme-lottie', classes: 'theme-lottie', [])],
            ),
            div(
              classes: 'navbar__lang',
              attributes: {'title': s.langSwitchLabel},
              langLinks,
            ),
            label(
              htmlFor: 'nav-toggle',
              classes: 'navbar__hamburger',
              attributes: const {'aria-label': 'Toggle menu'},
              [
                span(classes: 'navbar__bar', []),
                span(classes: 'navbar__bar', []),
                span(classes: 'navbar__bar', []),
              ],
            ),
          ]),
        ]),
        // Mobile dropdown (shown when checkbox is checked)
        div(classes: 'navbar__mobile-menu', [
          for (final item in links)
            Link(
              to: item.href,
              classes: 'navbar__mobile-link${_pathMatches(path, item.href) ? ' active' : ''}',
              children: [.text(item.label)],
            ),
          div(
            classes: 'navbar__mobile-lang',
            attributes: {'title': s.langSwitchLabel},
            langLinks,
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
