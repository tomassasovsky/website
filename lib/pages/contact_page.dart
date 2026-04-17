import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/contact_form.dart';
import '../data/contact_data.dart';
import '../data/site_data.dart';
import '../l10n/l10n_extension.dart';

class ContactPage extends StatelessComponent {
  const ContactPage({super.key});

  @override
  Component build(BuildContext context) {
    final s = context.strings;
    final locale = context.locale;

    return .fragment([
      Document.head(title: s.metaTitleContact),
      div(classes: 'page', [
        div(classes: 'container', [
          div(classes: 'section', [
            div(classes: 'section-header', [
              p(classes: 'section-label', [.text(s.contactGetInTouch)]),
              h1(classes: 'section-title', [.text(s.contactHeading)]),
              p(classes: 'section-subtitle', [.text(s.contactSubtitle)]),
            ]),
            div(classes: 'contact-layout', [
              // ── Left: contact form ──────────────────────────────────────
              div(classes: 'contact-card contact-card--form', [
                h2(classes: 'contact-card__title', [.text(s.contactFormTitle)]),
                p(classes: 'contact-card__desc', [.text(s.contactFormDesc)]),
                ContactForm(localeCode: locale.languageCode),
              ]),
              // ── Right: booking + socials ────────────────────────────────
              div(classes: 'contact-sidebar', [
                div(classes: 'contact-card', [
                  h2(classes: 'contact-card__title', [.text(s.contactBookTitle)]),
                  div(classes: 'contact-card__desc', [
                    p([.text(s.contactBookLine1)]),
                    p([.text(s.contactBookLine2)]),
                  ]),
                  a(
                    href: bookingUrl,
                    classes: 'btn btn-primary',
                    attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
                    [.text(s.contactScheduleCall)],
                  ),
                ]),
                div(classes: 'contact-card', [
                  h2(classes: 'contact-card__title', [.text(s.contactOnlineTitle)]),
                  p(classes: 'contact-card__desc', [.text(s.contactOnlineBody)]),
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
        ]),
      ]),
    ]);
  }
}
