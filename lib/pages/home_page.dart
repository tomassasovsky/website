import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/clients_data.dart';
import '../data/portfolio_content.dart';
import '../data/site_data.dart';
import '../l10n/l10n_extension.dart';
import '../l10n/paths.dart';
import '../models/models.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    final s = context.strings;
    final locale = context.locale;
    final aboutParagraphs = loadAboutParagraphs(s);
    final services = loadServices(s);
    final testimonials = loadTestimonials(s);

    return .fragment([
      Document.head(title: s.metaTitleHome),
      div(classes: 'page', [
        div(classes: 'container', [
          _Hero(
            siteName: siteName,
            tagline: s.siteTagline,
            location: s.siteLocation,
            badge: s.heroBadge,
            primaryCta: s.heroPrimaryCta,
            secondaryCta: s.heroSecondaryCta,
            contactHref: AppPaths.contact(locale),
            projectsHref: AppPaths.projects(locale),
          ),
          hr(classes: 'divider'),
          _AboutSection(
            sectionAbout: s.sectionAbout,
            sectionWhoIAm: s.sectionWhoIAm,
            sectionAboutSubtitle: s.sectionAboutSubtitle,
            paragraphs: aboutParagraphs,
          ),
          hr(classes: 'divider'),
          _ServicesSection(
            sectionServices: s.sectionServices,
            sectionWhatIDo: s.sectionWhatIDo,
            services: services,
          ),
          hr(classes: 'divider'),
          _ClientsSection(
            sectionExperience: s.sectionExperience,
            sectionTrustedBy: s.sectionTrustedBy,
          ),
          hr(classes: 'divider'),
          _TestimonialsSection(
            sectionTestimonials: s.sectionTestimonials,
            sectionWhatPeopleSay: s.sectionWhatPeopleSay,
            testimonials: testimonials,
          ),
        ]),
      ]),
    ]);
  }
}

class _Hero extends StatelessComponent {
  const _Hero({
    required this.siteName,
    required this.tagline,
    required this.location,
    required this.badge,
    required this.primaryCta,
    required this.secondaryCta,
    required this.contactHref,
    required this.projectsHref,
  });

  final String siteName;
  final String tagline;
  final String location;
  final String badge;
  final String primaryCta;
  final String secondaryCta;
  final String contactHref;
  final String projectsHref;

  @override
  Component build(BuildContext context) {
    return div(classes: 'hero', [
      div(classes: 'hero__text', [
        div(classes: 'hero__badge', [.text(badge)]),
        h1(classes: 'hero__name', [
          span(classes: 'hero__name-accent', [.text(siteName.split(' ').first)]),
          .text(' ${siteName.split(' ').last}'),
        ]),
        p(classes: 'hero__tagline', [.text(tagline)]),
        p(classes: 'hero__location', [.text('📍  $location')]),
        div(classes: 'hero__actions', [
          a(href: contactHref, classes: 'btn btn-primary', [.text(primaryCta)]),
          a(href: projectsHref, classes: 'btn btn-ghost', [.text(secondaryCta)]),
        ]),
      ]),
      img(
        src: siteAvatar,
        alt: siteName,
        classes: 'hero__image',
      ),
    ]);
  }
}

class _AboutSection extends StatelessComponent {
  const _AboutSection({
    required this.sectionAbout,
    required this.sectionWhoIAm,
    required this.sectionAboutSubtitle,
    required this.paragraphs,
  });

  final String sectionAbout;
  final String sectionWhoIAm;
  final String sectionAboutSubtitle;
  final List<String> paragraphs;

  @override
  Component build(BuildContext context) {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionAbout)]),
        h2(classes: 'section-title', [.text(sectionWhoIAm)]),
        p(classes: 'section-subtitle', [
          .text(sectionAboutSubtitle),
        ]),
      ]),
      div(classes: 'about-text', [
        for (final paragraph in paragraphs) p([.text(paragraph)]),
      ]),
    ]);
  }
}

class _ServicesSection extends StatelessComponent {
  const _ServicesSection({
    required this.sectionServices,
    required this.sectionWhatIDo,
    required this.services,
  });

  final String sectionServices;
  final String sectionWhatIDo;
  final List<Service> services;

  @override
  Component build(BuildContext context) {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionServices)]),
        h2(classes: 'section-title', [.text(sectionWhatIDo)]),
      ]),
      div(classes: 'services-grid', [
        for (final service in services) _ServiceCard(service: service),
      ]),
    ]);
  }
}

class _ServiceCard extends StatelessComponent {
  const _ServiceCard({required this.service});

  final Service service;

  @override
  Component build(BuildContext context) {
    return div(classes: 'service-card', [
      img(src: service.icon, alt: service.title, classes: 'service-card__icon'),
      p(classes: 'service-card__title', [.text(service.title)]),
      p(classes: 'service-card__desc', [.text(service.description)]),
    ]);
  }
}

class _ClientsSection extends StatelessComponent {
  const _ClientsSection({
    required this.sectionExperience,
    required this.sectionTrustedBy,
  });

  final String sectionExperience;
  final String sectionTrustedBy;

  @override
  Component build(BuildContext context) {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionExperience)]),
        h2(classes: 'section-title', [.text(sectionTrustedBy)]),
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
}

class _TestimonialsSection extends StatelessComponent {
  const _TestimonialsSection({
    required this.sectionTestimonials,
    required this.sectionWhatPeopleSay,
    required this.testimonials,
  });

  final String sectionTestimonials;
  final String sectionWhatPeopleSay;
  final List<Testimonial> testimonials;

  @override
  Component build(BuildContext context) {
    return div(classes: 'section', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionTestimonials)]),
        h2(classes: 'section-title', [.text(sectionWhatPeopleSay)]),
      ]),
      div(classes: 'testimonials-grid', [
        for (final t in testimonials) _TestimonialCard(t: t),
      ]),
    ]);
  }
}

class _TestimonialCard extends StatelessComponent {
  const _TestimonialCard({required this.t});

  final Testimonial t;

  @override
  Component build(BuildContext context) {
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
