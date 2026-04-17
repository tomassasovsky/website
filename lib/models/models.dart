class SocialLink {
  final String label;
  final String href;
  const SocialLink({required this.label, required this.href});
}

class Service {
  final String title;
  final String icon;
  final String description;
  const Service({required this.title, required this.icon, required this.description});
}

class ProjectLink {
  final String label;
  final String href;
  const ProjectLink({required this.label, required this.href});
}

class Project {
  final String title;
  final String description;
  final String? image;
  final String imageFit;
  final List<String> tech;
  final List<ProjectLink> links;
  final List<String> categories;
  final bool unreleased;

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
}

class Role {
  final String title;
  final String range;
  final String description;
  const Role({required this.title, required this.range, required this.description});
}

class Testimonial {
  final String author;
  final List<String> paragraphs;
  final String dateISO;
  final String dateLabel;
  final String linkedinUrl;
  const Testimonial({
    required this.author,
    required this.paragraphs,
    required this.dateISO,
    required this.dateLabel,
    required this.linkedinUrl,
  });
}

class Client {
  final String name;
  final String? logo;
  final String? darkLogo;
  final String url;
  const Client({required this.name, required this.url, this.logo, this.darkLogo});

  /// Logo to show on a dark background.
  String? get effectiveLogo => darkLogo ?? logo;
}
