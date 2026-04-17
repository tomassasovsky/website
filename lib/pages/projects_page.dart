import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/projects_data.dart';
import '../models/models.dart';

@client
class ProjectsPage extends StatefulComponent {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage> {
  String _filter = 'All';

  static const _filters = ['All', 'Apps', 'OSS / Tools'];

  @override
  Component build(BuildContext context) {
    final filtered = _filter == 'All' ? projects : projects.where((proj) => proj.categories.contains(_filter)).toList();

    return div(classes: 'page', [
      div(classes: 'container', [
        div(classes: 'section', [
          div(classes: 'section-header', [
            p(classes: 'section-label', [.text('Portfolio')]),
            h1(classes: 'section-title', [.text('Projects')]),
            p(classes: 'section-subtitle', [
              .text('${projects.length} projects across mobile, backend, and open source.'),
            ]),
          ]),
          div(classes: 'projects-filters', [
            for (final f in _filters)
              button(
                classes: 'filter-btn${_filter == f ? ' active' : ''}',
                onClick: () => setState(() => _filter = f),
                [.text(f)],
              ),
          ]),
          div(classes: 'projects-grid', [
            for (final project in filtered) _buildProjectCard(project),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildProjectCard(Project project) {
    return div(classes: 'project-card', [
      if (project.image != null)
        img(
          src: project.image!,
          alt: project.title,
          classes: 'project-card__img${project.imageFit == 'contain' ? ' project-card__img--contain' : ''}',
        )
      else
        div(classes: 'project-card__placeholder', [
          span(classes: 'project-card__placeholder-text', [.text('{ }')]),
        ]),
      div(classes: 'project-card__body', [
        div(classes: 'project-card__header', [
          h3(classes: 'project-card__title', [.text(project.title)]),
          if (project.unreleased) span(classes: 'project-card__badge', [.text('Unreleased')]),
        ]),
        p(classes: 'project-card__desc', [.text(project.description)]),
        if (project.tech.isNotEmpty)
          div(classes: 'project-card__tech', [
            for (final tech in project.tech) span(classes: 'tech-badge', [.text(tech)]),
          ]),
        if (project.links.isNotEmpty)
          div(classes: 'project-card__links', [
            for (final link in project.links)
              a(
                href: link.href,
                classes: 'project-link',
                attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
                [.text(link.label)],
              ),
          ]),
      ]),
    ]);
  }
}
