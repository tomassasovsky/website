import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/about_data.dart';
import '../data/clients_data.dart';
import '../data/site_data.dart';
import '../data/testimonials_data.dart';
import '../models/models.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'page', [
      div(classes: 'container', [
        _buildHero(),
        hr(classes: 'divider'),
        _buildAbout(),
        hr(classes: 'divider'),
        _buildServices(),
        hr(classes: 'divider'),
        _buildClients(),
        hr(classes: 'divider'),
        _buildTestimonials(),
      ]),
    ]);
  }

  Component _buildHero() {
    return div(classes: 'hero', [
      div(classes: 'hero__text', [
        div(classes: 'hero__badge', [.text('Available for new opportunities')]),
        h1(classes: 'hero__name', [
          span(classes: 'hero__name-accent', [.text(siteName.split(' ').first)]),
          .text(' ${siteName.split(' ').last}'),
        ]),
        p(classes: 'hero__tagline', [.text(siteTagline)]),
        p(classes: 'hero__location', [.text('📍  $siteLocation')]),
        div(classes: 'hero__actions', [
          a(href: '/contact', classes: 'btn btn-primary', [.text("Let's talk →")]),
          a(href: '/projects', classes: 'btn btn-ghost', [.text('See my work')]),
        ]),
      ]),
      img(
        src: siteAvatar,
        alt: siteName,
        classes: 'hero__image',
      ),
    ]);
  }

  Component _buildAbout() {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text('About me')]),
        h2(classes: 'section-title', [.text('Who I am')]),
        p(classes: 'section-subtitle', [
          .text('Engineer, builder, open-source contributor.'),
        ]),
      ]),
      div(classes: 'about-text', [
        for (final paragraph in aboutParagraphs) p([.text(paragraph)]),
      ]),
    ]);
  }

  Component _buildServices() {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text('Services')]),
        h2(classes: 'section-title', [.text('What I do')]),
      ]),
      div(classes: 'services-grid', [
        for (final service in services) _buildServiceCard(service),
      ]),
    ]);
  }

  Component _buildServiceCard(Service service) {
    return div(classes: 'service-card', [
      img(src: service.icon, alt: service.title, classes: 'service-card__icon'),
      p(classes: 'service-card__title', [.text(service.title)]),
      p(classes: 'service-card__desc', [.text(service.description)]),
    ]);
  }

  Component _buildClients() {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text('Experience')]),
        h2(classes: 'section-title', [.text('Trusted by')]),
      ]),
      div(classes: 'clients-grid', [
        for (final client in clients)
          if (client.effectiveLogo != null)
            a(
              href: client.url,
              attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
              [
                img(
                  src: client.effectiveLogo!,
                  alt: client.name,
                  classes: 'client-logo',
                ),
              ],
            ),
      ]),
    ]);
  }

  Component _buildTestimonials() {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text('Testimonials')]),
        h2(classes: 'section-title', [.text('What people say')]),
      ]),
      div(classes: 'testimonials-grid', [
        for (final t in testimonials) _buildTestimonialCard(t),
      ]),
    ]);
  }

  Component _buildTestimonialCard(Testimonial t) {
    return div(classes: 'testimonial-card', [
      div(classes: 'testimonial-card__meta', [
        span(classes: 'testimonial-card__author', [.text(t.author)]),
        a(
          href: t.linkedinUrl,
          classes: 'testimonial-card__linkedin',
          attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
          [.text(t.dateLabel)],
        ),
      ]),
      div(classes: 'testimonial-card__body', [
        for (final paragraph in t.paragraphs) p([.text(paragraph)]),
      ]),
    ]);
  }
}
