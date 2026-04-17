import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer(classes: 'footer', [
      div(classes: 'container', [
        p(classes: 'footer__text', [
          .text('© ${DateTime.now().year} Tomás Sasovsky · Built with '),
          a(
            href: 'https://jaspr.site',
            attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
            [.text('Jaspr')],
          ),
          .text(' & Dart'),
        ]),
      ]),
    ]);
  }
}
