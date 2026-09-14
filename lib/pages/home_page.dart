import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/testimonials_carousel.dart';
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
    final aboutParagraphs = loadAboutText(s);
    final services = loadServices(s);

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
          _SelectedWork(
            title: s.selectedWork,
            viewAll: s.viewAllProjects,
            projects: loadProjects(s).take(2).toList(),
            projectsHref: AppPaths.projects(locale),
          ),
          hr(classes: 'divider'),
          _AboutSection(
            sectionAbout: s.sectionAbout,
            sectionWhoIAm: s.sectionWhoIAm,
            sectionAboutSubtitle: s.sectionAboutSubtitle,
            paragraphs: aboutParagraphs,
            statYearsExperience: s.statYearsExperience,
            statProjectsShipped: s.statProjectsShipped,
            statContinentsServed: s.statContinentsServed,
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
            localeCode: locale.languageCode,
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
        p(classes: 'hero__eyebrow', [.text(tagline)]),
        h1(classes: 'hero__name', [.text(siteName)]),
        p(classes: 'hero__tagline', [.text(context.strings.heroIntro)]),
        div(classes: 'hero__stack', [
          for (final tech in const ['Flutter', 'Dart', 'TypeScript', 'Node.js', 'GCP'])
            span(classes: 'stack-tag', [.text(tech)]),
        ]),
        div(classes: 'hero__actions', [
          a(href: projectsHref, classes: 'btn btn-primary', [.text(secondaryCta), .text(' ↗')]),
          a(href: contactHref, classes: 'btn btn-ghost', [.text(primaryCta)]),
        ]),
        div(classes: 'hero__badge', [.text(badge)]),
      ]),
      div(classes: 'hero__portrait', [
        img(
          src: siteAvatar,
          alt: siteName,
          classes: 'hero__image',
          attributes: const {'width': '256', 'height': '256'},
        ),
        p(classes: 'hero__location', [.text(location)]),
      ]),
    ]);
  }
}

class _AboutSection extends StatelessComponent {
  const _AboutSection({
    required this.sectionAbout,
    required this.sectionWhoIAm,
    required this.sectionAboutSubtitle,
    required this.paragraphs,
    required this.statYearsExperience,
    required this.statProjectsShipped,
    required this.statContinentsServed,
  });

  final String sectionAbout;
  final String sectionWhoIAm;
  final String sectionAboutSubtitle;
  final List<String> paragraphs;
  final String statYearsExperience;
  final String statProjectsShipped;
  final String statContinentsServed;

  @override
  Component build(BuildContext context) {
    return div(classes: 'section section--split', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionAbout)]),
        h2(classes: 'section-title', [.text(sectionWhoIAm)]),
      ]),
      div(classes: 'section-content', [
        p(classes: 'about-intro', [.text(sectionAboutSubtitle)]),
        div(classes: 'about-text', [
          for (final paragraph in paragraphs) p([.text(paragraph)]),
        ]),
        div(classes: 'about-stats', [
          _Stat(value: '5+', label: statYearsExperience),
          _Stat(value: '14+', label: statProjectsShipped),
          _Stat(value: '3', label: statContinentsServed),
        ]),
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
    return div(classes: 'section section--split', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionServices)]),
        h2(classes: 'section-title', [.text(sectionWhatIDo)]),
      ]),
      div(classes: 'services-grid', [
        for (var i = 0; i < services.length; i++) _ServiceCard(service: services[i], index: i + 1),
      ]),
    ]);
  }
}

class _ServiceCard extends StatelessComponent {
  const _ServiceCard({required this.service, required this.index});

  final Service service;
  final int index;

  @override
  Component build(BuildContext context) {
    return div(classes: 'service-card', [
      span(classes: 'service-card__number', [.text(index.toString().padLeft(2, '0'))]),
      div([
        h3(classes: 'service-card__title', [.text(service.title)]),
        p(classes: 'service-card__desc', [.text(service.description)]),
      ]),
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
    return div(classes: 'section section--split', [
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
              [img(src: client.effectiveLogo!, alt: client.name, classes: 'client-logo')],
            ),
      ]),
    ]);
  }
}

class _TestimonialsSection extends StatelessComponent {
  const _TestimonialsSection({
    required this.sectionTestimonials,
    required this.sectionWhatPeopleSay,
    required this.localeCode,
  });

  final String sectionTestimonials;
  final String sectionWhatPeopleSay;
  final String localeCode;

  @override
  Component build(BuildContext context) {
    return div(classes: 'section section--split', [
      div(classes: 'section-header', [
        p(classes: 'section-label', [.text(sectionTestimonials)]),
        h2(classes: 'section-title', [.text(sectionWhatPeopleSay)]),
      ]),
      TestimonialsCarousel(localeCode: localeCode),
    ]);
  }
}

class _SelectedWork extends StatelessComponent {
  const _SelectedWork({
    required this.title,
    required this.viewAll,
    required this.projects,
    required this.projectsHref,
  });

  final String title;
  final String viewAll;
  final List<Project> projects;
  final String projectsHref;

  @override
  Component build(BuildContext context) {
    return section(classes: 'section selected-work', [
      div(classes: 'section-header section-header--inline', [
        h2(classes: 'section-title', [.text(title)]),
        a(href: projectsHref, classes: 'text-link', [.text(viewAll), .text(' ↗')]),
      ]),
      div(classes: 'selected-work__grid', [
        for (final (index, project) in projects.indexed)
          a(href: '$projectsHref#project-$index', classes: 'work-preview', [
            img(
              src: project.image!,
              alt: '',
              classes: 'work-preview__image',
              attributes: const {'loading': 'lazy', 'width': '640', 'height': '360'},
            ),
            div(classes: 'work-preview__caption', [
              h3([.text(project.title)]),
              span(attributes: const {'aria-hidden': 'true'}, [.text('↗')]),
            ]),
            p(classes: 'work-preview__tech', [.text(project.tech.join(' / '))]),
          ]),
      ]),
    ]);
  }
}

class _Stat extends StatelessComponent {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Component build(BuildContext context) {
    return div(classes: 'about-stat', [
      span(classes: 'about-stat__value', [.text(value)]),
      span(classes: 'about-stat__label', [.text(label)]),
    ]);
  }
}
