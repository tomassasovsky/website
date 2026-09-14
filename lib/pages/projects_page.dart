import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../data/portfolio_content.dart';
import '../l10n/generated/strings.g.dart';
import '../l10n/locale_codec.dart';
import '../l10n/l10n_extension.dart';
import '../models/models.dart';
import '../providers/projects_filter_provider.dart';

const _kAll = 'all';
const _kApps = 'apps';
const _kOss = 'oss';

/// Portfolio projects with in-memory filter state (Riverpod), not URL-driven.
class ProjectsPage extends StatelessComponent {
  const ProjectsPage({super.key});

  @override
  Component build(BuildContext context) {
    final locale = context.locale;
    return .fragment([
      Document.head(title: context.strings.metaTitleProjects),
      ProjectsClientSection(localeCode: locale.languageCode),
    ]);
  }
}

@client
class ProjectsClientSection extends StatefulComponent {
  const ProjectsClientSection({required this.localeCode});

  /// Passed from the server shell; the hydrated client subtree is not under [LocaleScope].
  final String localeCode;

  @override
  State<ProjectsClientSection> createState() => _ProjectsClientSectionState();
}

class _ProjectsClientSectionState extends State<ProjectsClientSection> {
  var _hashFilterApplied = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!context.binding.isClient || _hashFilterApplied) return;
    _hashFilterApplied = true;

    final hash = web.window.location.hash.toLowerCase();
    if (hash == '#oss' || hash == '#apps') {
      context.read(projectsFilterProvider.notifier).state = hash.substring(1);
    } else if (hash.startsWith('#project-')) {
      final index = int.tryParse(hash.substring('#project-'.length));
      final locale = localeFromPathSegment(component.localeCode) ?? AppLocale.en;
      final projects = loadProjects(locale.buildSync());
      if (index != null && index >= 0 && index < projects.length) {
        final project = projects[index];
        context.read(projectsFilterProvider.notifier).state = project.categories.contains(_kOss) ? _kOss : _kApps;
        context.read(selectedProjectProvider.notifier).state = project;
      }
    }
  }

  @override
  Component build(BuildContext context) {
    final locale = localeFromPathSegment(component.localeCode) ?? AppLocale.en;
    final s = locale.buildSync();
    final projects = loadProjects(locale.buildSync());
    final raw = context.watch(projectsFilterProvider);
    final activeFilter = (raw == _kApps || raw == _kOss) ? raw : _kAll;
    final selectedProject = context.watch(selectedProjectProvider);

    final filters = <({String key, String label})>[
      (key: _kAll, label: s.filterAll),
      (key: _kApps, label: s.filterApps),
      (key: _kOss, label: s.filterOss),
    ];

    final filtered = activeFilter == _kAll
        ? projects
        : projects.where((proj) => proj.categories.contains(activeFilter)).toList();

    void closeModal() {
      context.read(selectedProjectProvider.notifier).state = null;
    }

    return div(classes: 'page', [
      div(classes: 'container', [
        div(classes: 'section', [
          div(classes: 'section-header', [
            p(classes: 'section-label', [.text(s.portfolioLabel)]),
            h1(classes: 'section-title', [.text(s.projectsHeading)]),
            p(classes: 'section-subtitle', [
              .text(s.projectsSubtitle(projectCount: projects.length)),
            ]),
          ]),
          div(classes: 'projects-filters', [
            for (final f in filters)
              button(
                classes: 'filter-btn${activeFilter == f.key ? ' active' : ''}',
                attributes: {'aria-pressed': '${activeFilter == f.key}'},
                onClick: () {
                  final next = (f.key == _kApps || f.key == _kOss) ? f.key : _kAll;
                  context.read(projectsFilterProvider.notifier).state = next;
                },
                [.text(f.label)],
              ),
          ]),
          div(classes: 'projects-grid', [
            for (final project in filtered)
              _ProjectCard(
                project: project,
                strings: s,
                onTap: () {
                  context.read(selectedProjectProvider.notifier).state = project;
                },
              ),
          ]),
          if (activeFilter == _kApps || activeFilter == _kOss)
            div(classes: 'projects-cta', [
              button(
                classes: 'filter-btn projects-cta__btn',
                onClick: () {
                  context.read(projectsFilterProvider.notifier).state = activeFilter == _kApps ? _kOss : _kApps;
                  Future.delayed(
                    Duration.zero,
                    () => web.window.scrollTo(web.ScrollToOptions(top: 0, behavior: 'smooth')),
                  );
                },
                [
                  .text(
                    activeFilter == _kApps ? s.projectsCtaOss : s.projectsCtaApps,
                  ),
                ],
              ),
            ]),
        ]),
      ]),
      if (selectedProject != null)
        _ProjectModal(
          project: selectedProject,
          strings: s,
          onClose: closeModal,
        ),
    ]);
  }
}

class _ProjectCard extends StatelessComponent {
  const _ProjectCard({
    required this.project,
    required this.strings,
    required this.onTap,
  });

  final Project project;
  final AppLocalizations strings;
  final VoidCallback onTap;

  @override
  Component build(BuildContext context) {
    final s = strings;
    return div(
      classes: 'project-card${project.categories.contains(_kOss) ? ' project-card--tool' : ''}',
      [
        if (project.image != null && !project.categories.contains(_kOss))
          button(
            classes: 'project-card__image-button',
            attributes: {'aria-label': project.title, 'aria-haspopup': 'dialog'},
            onClick: onTap,
            [
              img(
                src: project.image!,
                alt: '',
                attributes: const {'loading': 'lazy', 'width': '640', 'height': '360'},
                classes: 'project-card__img',
              ),
            ],
          ),
        div(classes: 'project-card__body', [
          div(classes: 'project-card__header', [
            h2(classes: 'project-card__title', [
              button(
                classes: 'project-card__open',
                attributes: const {'aria-haspopup': 'dialog'},
                onClick: onTap,
                [.text(project.title)],
              ),
            ]),
            if (project.unreleased) span(classes: 'project-card__badge', [.text(s.projectUnreleased)]),
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
      ],
    );
  }
}

class _ProjectModal extends StatefulComponent {
  const _ProjectModal({
    required this.project,
    required this.strings,
    required this.onClose,
  });

  final Project project;
  final AppLocalizations strings;
  final VoidCallback onClose;

  @override
  State<_ProjectModal> createState() => _ProjectModalState();
}

class _ProjectModalState extends State<_ProjectModal> {
  late final web.EventListener _keyHandler;
  web.HTMLElement? _previousFocus;

  @override
  void initState() {
    super.initState();
    _previousFocus = web.document.activeElement as web.HTMLElement?;
    Future<void>.delayed(Duration.zero, () {
      if (!mounted) return;
      (web.document.querySelector('.project-modal__close') as web.HTMLElement?)?.focus();
    });
    _keyHandler = (web.Event e) {
      final key = e as web.KeyboardEvent;
      if (key.key == 'Escape') {
        e.preventDefault();
        component.onClose();
      } else if (key.key == 'Tab') {
        final controls = web.document.querySelectorAll('.project-modal button, .project-modal a[href]');
        if (controls.length == 0) return;
        final first = controls.item(0) as web.HTMLElement;
        final last = controls.item(controls.length - 1) as web.HTMLElement;
        final focused = web.document.activeElement;
        if (key.shiftKey && focused == first) {
          e.preventDefault();
          last.focus();
        } else if (!key.shiftKey && focused == last) {
          e.preventDefault();
          first.focus();
        }
      }
    }.toJS;
    web.document.addEventListener('keydown', _keyHandler);
  }

  @override
  void dispose() {
    web.document.removeEventListener('keydown', _keyHandler);
    if (_previousFocus?.isConnected ?? false) _previousFocus?.focus();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    final s = component.strings;
    final project = component.project;
    final onClose = component.onClose;
    return div(
      classes: 'project-modal-backdrop',
      events: events(onClick: onClose),
      [
        div(
          classes: 'project-modal',
          attributes: const {'role': 'dialog', 'aria-modal': 'true', 'aria-labelledby': 'project-modal-title'},
          events: {
            'click': (e) => e.stopPropagation(),
          },
          [
            button(
              classes: 'project-modal__close',
              attributes: {'aria-label': s.closeProject, 'autofocus': ''},
              onClick: onClose,
              [.text('×')],
            ),
            if (project.image != null && !project.categories.contains(_kOss))
              img(
                src: project.image!,
                alt: project.title,
                classes: 'project-modal__img',
                attributes: const {'width': '640', 'height': '360'},
              ),
            div(classes: 'project-modal__body', [
              div(classes: 'project-card__header', [
                h2(id: 'project-modal-title', classes: 'project-modal__title', [.text(project.title)]),
                if (project.unreleased) span(classes: 'project-card__badge', [.text(s.projectUnreleased)]),
              ]),
              p(classes: 'project-modal__desc', [.text(project.description)]),
              if (project.tech.isNotEmpty)
                div(classes: 'project-card__tech', [
                  for (final tech in project.tech) span(classes: 'tech-badge', [.text(tech)]),
                ]),
              if (project.links.isNotEmpty)
                div(classes: 'project-card__links', [
                  for (final link in project.links)
                    a(
                      href: link.href,
                      classes: 'project-link project-link--lg',
                      attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
                      [.text(link.label)],
                    ),
                ]),
            ]),
          ],
        ),
      ],
    );
  }
}
