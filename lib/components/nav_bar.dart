import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_data.dart';

class NavBar extends StatelessComponent {
  const NavBar({super.key});

  static const _links = [
    (href: '/', label: 'About'),
    (href: '/projects', label: 'Projects'),
    (href: '/contact', label: 'Contact'),
  ];

  @override
  Component build(BuildContext context) {
    final path = context.url;

    return nav(classes: 'navbar', [
      div(classes: 'container', [
        div(classes: 'navbar__inner', [
          a(href: '/', classes: 'navbar__brand', [
            .text('${siteName.split(' ').first} '),
            span([.text(siteName.split(' ').last)]),
          ]),
          ul(classes: 'navbar__links', [
            for (final item in _links)
              li([
                a(
                  href: item.href,
                  classes: 'navbar__link${path == item.href ? ' active' : ''}',
                  [.text(item.label)],
                ),
              ]),
          ]),
        ]),
      ]),
    ]);
  }
}
