import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../l10n/l10n_extension.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    final s = context.strings;
    final year = DateTime.now().year;
    return footer(classes: 'footer', [
      div(classes: 'container', [
        p(classes: 'footer__text', [
          .text(s.footerCopyright(year: year)),
          a(
            href: 'https://jaspr.site',
            attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
            [.text('Jaspr')],
          ),
          .text(' & '),
          a(
            href: 'https://dart.dev',
            attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
            [.text('Dart')],
          ),
        ]),
      ]),
    ]);
  }
}
