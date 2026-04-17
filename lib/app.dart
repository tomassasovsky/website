import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/footer.dart';
import 'components/nav_bar.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';
import 'pages/projects_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'site-wrapper', [
      const NavBar(),
      Router(
        routes: [
          Route(
            path: '/',
            title: 'About — Tomás Sasovsky',
            builder: (context, state) => const HomePage(),
          ),
          Route(
            path: '/projects',
            title: 'Projects — Tomás Sasovsky',
            builder: (context, state) => const ProjectsPage(),
          ),
          Route(
            path: '/contact',
            title: 'Contact — Tomás Sasovsky',
            builder: (context, state) => const ContactPage(),
          ),
        ],
      ),
      const Footer(),
    ]);
  }
}
