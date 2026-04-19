import 'package:jaspr_riverpod/legacy.dart';

import '../models/models.dart';

/// Sync key for SSR → client hydration (must match [main.server] and [main.client]).
const kProjectsFilterSyncId = 'projects_filter_v1';

/// In-memory project filter: `all`, `apps`, or `oss` (not stored in the URL).
final projectsFilterProvider = StateProvider<String>((ref) => 'apps');

/// The project currently shown in the detail modal, or null when closed.
final selectedProjectProvider = StateProvider<Project?>((ref) => null);
