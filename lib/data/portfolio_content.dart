import '../l10n/generated/strings.g.dart';
import '../models/models.dart';
import 'link_kind.dart';
import 'project_catalog.dart';

String linkLabel(AppLocalizations t, LinkKind k) {
  return switch (k) {
    LinkKind.googlePlay => t.labelGooglePlay,
    LinkKind.appStore => t.labelAppStore,
    LinkKind.website => t.labelWebsite,
    LinkKind.documentation => t.labelDocumentation,
    LinkKind.github => t.labelGithub,
    LinkKind.discord => t.labelDiscord,
  };
}

List<String> loadAboutParagraphs(AppLocalizations t) => [t.aboutP0, t.aboutP1];

List<Service> loadServices(AppLocalizations t) {
  return [
    Service(title: t.svc0Title, icon: '/assets/images/icon-app.svg', description: t.svc0Desc),
    Service(title: t.svc1Title, icon: '/assets/images/icon-dev.svg', description: t.svc1Desc),
    Service(title: t.svc2Title, icon: '/assets/images/icon-dev.svg', description: t.svc2Desc),
    Service(title: t.svc3Title, icon: '/assets/images/icon-app.svg', description: t.svc3Desc),
    Service(title: t.svc4Title, icon: '/assets/images/icon-dev.svg', description: t.svc4Desc),
  ];
}

String _projectTitle(AppLocalizations t, int i) {
  return switch (i) {
    0 => t.proj0Title,
    1 => t.proj1Title,
    2 => t.proj2Title,
    3 => t.proj3Title,
    4 => t.proj4Title,
    5 => t.proj5Title,
    6 => t.proj6Title,
    7 => t.proj7Title,
    8 => t.proj8Title,
    9 => t.proj9Title,
    10 => t.proj10Title,
    11 => t.proj11Title,
    12 => t.proj12Title,
    13 => t.proj13Title,
    _ => throw RangeError('project index $i'),
  };
}

String _projectDesc(AppLocalizations t, int i) {
  return switch (i) {
    0 => t.proj0Desc,
    1 => t.proj1Desc,
    2 => t.proj2Desc,
    3 => t.proj3Desc,
    4 => t.proj4Desc,
    5 => t.proj5Desc,
    6 => t.proj6Desc,
    7 => t.proj7Desc,
    8 => t.proj8Desc,
    9 => t.proj9Desc,
    10 => t.proj10Desc,
    11 => t.proj11Desc,
    12 => t.proj12Desc,
    13 => t.proj13Desc,
    _ => throw RangeError('project index $i'),
  };
}

List<Project> loadProjects(AppLocalizations t) {
  assert(projectShells.length == 14);
  return [
    for (var i = 0; i < projectShells.length; i++) _projectAt(t, i),
  ];
}

Project _projectAt(AppLocalizations t, int i) {
  final shell = projectShells[i];
  return Project(
    title: _projectTitle(t, i),
    description: _projectDesc(t, i),
    image: shell.image,
    imageFit: shell.imageFit,
    tech: shell.tech,
    categories: shell.categories,
    unreleased: shell.unreleased,
    links: [
      for (final entry in shell.links) ProjectLink(label: linkLabel(t, entry.$1), href: entry.$2),
    ],
  );
}

const _testimonialShells = <({String author, String dateISO, String linkedinUrl})>[
  (
    author: 'Jorge Rincon Arias',
    dateISO: '2025-10-08',
    linkedinUrl: 'https://www.linkedin.com/in/jorgejrincon/',
  ),
  (
    author: 'Tomás Tisocco',
    dateISO: '2025-01-27',
    linkedinUrl: 'https://www.linkedin.com/in/tomastisocco/',
  ),
  (
    author: 'Michael Mathieu',
    dateISO: '2025-01-25',
    linkedinUrl: 'https://www.linkedin.com/in/michael-mathieu-b1973571/',
  ),
  (
    author: 'Nicolás Rodsevich',
    dateISO: '2021-11-22',
    linkedinUrl: 'https://www.linkedin.com/in/nicolas-rodsevich/',
  ),
  (
    author: 'Ignacio Suarez Smith',
    dateISO: '2021-11-22',
    linkedinUrl: 'https://www.linkedin.com/in/ignaciossmith/',
  ),
];

String _testimonialDateLabel(AppLocalizations t, int i) {
  return switch (i) {
    0 => t.testi0Date,
    1 => t.testi1Date,
    2 => t.testi2Date,
    3 => t.testi3Date,
    4 => t.testi4Date,
    _ => throw RangeError('testimonial index $i'),
  };
}

List<String> _testimonialParagraphs(AppLocalizations t, int i) {
  return switch (i) {
    0 => [t.testi0P0, t.testi0P1, t.testi0P2],
    1 => [t.testi1P0, t.testi1P1, t.testi1P2],
    2 => [t.testi2P0, t.testi2P1, t.testi2P2],
    3 => [t.testi3P0],
    4 => [t.testi4P0],
    _ => throw RangeError('testimonial index $i'),
  };
}

List<Testimonial> loadTestimonials(AppLocalizations t) {
  return [
    for (var i = 0; i < _testimonialShells.length; i++)
      Testimonial(
        author: _testimonialShells[i].author,
        dateISO: _testimonialShells[i].dateISO,
        linkedinUrl: _testimonialShells[i].linkedinUrl,
        dateLabel: _testimonialDateLabel(t, i),
        paragraphs: _testimonialParagraphs(t, i),
      ),
  ];
}

List<Role> loadExperienceRoles(AppLocalizations t) {
  return [
    Role(title: t.exp0Title, range: t.exp0Range, description: t.exp0Desc),
    Role(title: t.exp1Title, range: t.exp1Range, description: t.exp1Desc),
    Role(title: t.exp2Title, range: t.exp2Range, description: t.exp2Desc),
    Role(title: t.exp3Title, range: t.exp3Range, description: t.exp3Desc),
    Role(title: t.exp4Title, range: t.exp4Range, description: t.exp4Desc),
    Role(title: t.exp5Title, range: t.exp5Range, description: t.exp5Desc),
  ];
}
