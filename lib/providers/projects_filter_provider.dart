import 'package:jaspr_riverpod/legacy.dart';

/// Sync key for SSR → client hydration (must match [main.server] and [main.client]).
const kProjectsFilterSyncId = 'projects_filter_v1';

/// In-memory project filter: `all`, `apps`, or `oss` (not stored in the URL).
final projectsFilterProvider = StateProvider<String>((ref) => 'all');
