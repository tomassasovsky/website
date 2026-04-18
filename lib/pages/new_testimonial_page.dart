import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/testimonial_form.dart';
import '../data/portfolio_content.dart';
import '../l10n/generated/strings.g.dart';
import '../l10n/locale_scope.dart';
import '../models/models.dart';

class NewTestimonialPage extends StatelessComponent {
  const NewTestimonialPage({super.key});

  @override
  Component build(BuildContext context) {
    final l10n = LocaleScope.of(context);
    final s = l10n.strings;
    final locale = l10n.locale;
    final testimonials = loadTestimonials(AppLocale.en.buildSync());

    return .fragment([
      Document.head(title: s.testiPageTitle),
      div(classes: 'page', [
        div(classes: 'container', [
          div(classes: 'section', [
            // ── Header ────────────────────────────────────────────────────────
            div(classes: 'section-header', [
              p(classes: 'section-label', [.text(s.sectionTestimonials)]),
              h1(classes: 'section-title', [.text(s.testiPageHeading)]),
              p(classes: 'section-subtitle', [.text(s.testiPageSubtitle)]),
            ]),

            // ── Examples ──────────────────────────────────────────────────────
            div(classes: 'contact-card', [
              h2(classes: 'contact-card__title', [.text(s.testiPageExamplesTitle)]),
              p(classes: 'contact-card__desc', [.text(s.testiPageExamplesDesc)]),
              div(classes: 'testimonial-examples', [
                for (final t in testimonials.take(3)) _TestimonialExample(testimonial: t),
              ]),
            ]),

            // ── Form ──────────────────────────────────────────────────────────
            div(classes: 'contact-card contact-card--form', [
              h2(classes: 'contact-card__title', [.text(s.testiPageFormTitle)]),
              p(classes: 'contact-card__desc', [.text(s.testiPageFormDesc)]),
              TestimonialForm(localeCode: locale.languageCode),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}

class _TestimonialExample extends StatelessComponent {
  const _TestimonialExample({required this.testimonial});

  final Testimonial testimonial;

  @override
  Component build(BuildContext context) {
    return div(classes: 'testimonial-example', [
      div(classes: 'testimonial-example__meta', [
        span(classes: 'tcard__author', [.text(testimonial.author)]),
        span(classes: 'tcard__date', [.text(' · ${testimonial.dateLabel}')]),
      ]),
      div(classes: 'tcard__body', [
        for (final para in testimonial.paragraphs) p([.text(para)]),
      ]),
    ]);
  }
}
