import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/footer.dart';
import 'components/nav_bar.dart';
import 'l10n/generated/strings.g.dart';
import 'l10n/locale_codec.dart';
import 'l10n/locale_scope.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';
import 'pages/new_testimonial_page.dart';
import 'pages/projects_page.dart';

String? _ensureLocalePrefix(BuildContext context, RouteState state) {
  final uri = Uri.parse(state.location);
  final path = uri.path.isEmpty ? '/' : uri.path;

  final segments = path.split('/').where((segment) => segment.isNotEmpty).toList();

  if (segments.isEmpty) {
    return '/en';
  }

  if (localeFromPathSegment(segments.first) == null) {
    return '/en/${segments.join('/')}';
  }

  return null;
}

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(
      redirect: _ensureLocalePrefix,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            final langCode = state.params['lang'];
            final locale = localeFromPathSegment(langCode) ?? AppLocale.en;
            final strings = locale.buildSync();
            return .fragment([
              Document.html(attributes: {'lang': locale.languageCode}),
              Document.head(
                children: [
                  // Inline script: apply stored theme immediately to prevent flash
                  script(
                    content:
                        "(function(){var t=localStorage.getItem('theme')||'dark';document.documentElement.setAttribute('data-theme',t);})();",
                  ),
                  // Favicon
                  link(rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg'),
                  // Disable link previews on WhatsApp, Telegram, etc.
                  meta(name: 'robots', content: 'noai, noimageai'),
                  // Lottie player (defer so it runs in order before theme.js)
                  script(
                    src: 'https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.12.2/lottie.min.js',
                    defer: true,
                  ),
                  script(src: '/scroll-avatar.js', defer: true),
                  script(src: '/theme.js', defer: true),
                  script(src: '/clients-carousel.js', defer: true),
                  // Plausible analytics
                  script(
                    src: 'https://stats.aquiles.dev/js/pa-72E8qMm_ZzdUZJw4uBtzt.js',
                    async: true,
                  ),
                  script(
                    content:
                        'window.plausible=window.plausible||function(){(plausible.q=plausible.q||[]).push(arguments)},plausible.init=plausible.init||function(i){plausible.o=i||{}};plausible.init()',
                  ),
                ],
              ),
              LocaleScope(
                locale: locale,
                strings: strings,
                child: div(classes: 'site-wrapper', [
                  const NavBar(),
                  child,
                  const Footer(),
                ]),
              ),
            ]);
          },
          routes: [
            Route(
              path: '/:lang',
              builder: (context, state) => const HomePage(),
              routes: [
                Route(
                  path: 'projects',
                  builder: (context, state) => const ProjectsPage(),
                ),
                Route(
                  path: 'contact',
                  builder: (context, state) => const ContactPage(),
                ),
                Route(
                  path: 'new-testimonial',
                  builder: (context, state) => const NewTestimonialPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
