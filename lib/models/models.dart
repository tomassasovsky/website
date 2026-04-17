class SocialLink {
  const SocialLink({
    required this.label,
    required this.href,
  });

  final String label;
  final String href;
}

class Service {
  const Service({
    required this.title,
    required this.icon,
    required this.description,
  });

  final String title;
  final String icon;
  final String description;
}

class ProjectLink {
  const ProjectLink({
    required this.label,
    required this.href,
  });

  final String label;
  final String href;
}

class Project {
  const Project({
    required this.title,
    required this.description,
    this.image,
    this.imageFit = 'cover',
    this.tech = const [],
    this.links = const [],
    this.categories = const [],
    this.unreleased = false,
  });

  final String title;
  final String description;
  final String? image;
  final String imageFit;
  final List<String> tech;
  final List<ProjectLink> links;
  final List<String> categories;
  final bool unreleased;
}

class Role {
  const Role({
    required this.title,
    required this.range,
    required this.description,
  });

  final String title;
  final String range;
  final String description;
}

class Testimonial {
  const Testimonial({
    required this.author,
    required this.paragraphs,
    required this.dateISO,
    required this.dateLabel,
    required this.linkedinUrl,
  });

  final String author;
  final List<String> paragraphs;
  final String dateISO;
  final String dateLabel;
  final String linkedinUrl;
}

class Client {
  const Client({
    required this.name,
    required this.url,
    this.logo,
    this.darkLogo,
  });

  final String name;
  final String? logo;
  final String? darkLogo;
  final String url;

  /// Logo to show on a dark background.
  String? get effectiveLogo => darkLogo ?? logo;
}
