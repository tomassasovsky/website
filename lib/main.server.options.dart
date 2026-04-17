// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:website/pages/projects_page.dart' as _projects_page;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _projects_page.ProjectsClientSection:
        ClientTarget<_projects_page.ProjectsClientSection>(
          'projects_page',
          params: __projects_pageProjectsClientSection,
        ),
  },
  stylesId: 'main.css',
);

Map<String, Object?> __projects_pageProjectsClientSection(
  _projects_page.ProjectsClientSection c,
) => {'localeCode': c.localeCode};
