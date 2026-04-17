import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/contact_data.dart';
import '../data/site_data.dart';

class ContactPage extends StatelessComponent {
  const ContactPage({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'page', [
      div(classes: 'container', [
        div(classes: 'section', [
          div(classes: 'section-header', [
            p(classes: 'section-label', [.text('Get in touch')]),
            h1(classes: 'section-title', [.text('Contact')]),
            p(classes: 'section-subtitle', [
              .text("Let's work together on something great."),
            ]),
          ]),
          div(classes: 'contact-grid', [
            // Booking card
            div(classes: 'contact-card', [
              h2(classes: 'contact-card__title', [.text('Book a meeting')]),
              div(classes: 'contact-card__desc', [
                for (final line in bookingDescription) p([.text(line)]),
              ]),
              a(
                href: bookingUrl,
                classes: 'btn btn-primary',
                attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
                [.text('Schedule a call →')],
              ),
            ]),
            // Socials card
            div(classes: 'contact-card', [
              h2(classes: 'contact-card__title', [.text('Find me online')]),
              p(classes: 'contact-card__desc', [
                .text(
                  'Reach out directly — always happy to chat about Flutter, '
                  'interesting projects, or new opportunities.',
                ),
              ]),
              div(classes: 'social-links', [
                for (final social in socials)
                  a(
                    href: social.href,
                    classes: 'social-link',
                    attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
                    [.text(social.label)],
                  ),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}
