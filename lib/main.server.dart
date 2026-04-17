/// The entrypoint for the **server** environment.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_riverpod/legacy.dart';

import 'app.dart';
import 'main.server.options.dart';
import 'middleware/serve_generated_client_js.dart';
import 'providers/projects_filter_provider.dart';

void main() {
  // Serves `/packages/...` and `/main.client*.js` from pub-cache / build output when
  // using `dart run lib/main.server.dart`. Always register (even if `JASPR_PROXY_PORT`
  // is set) so a stray env var does not skip this and break MIME types for DDC.
  ServerApp.addMiddleware(serveLocalDevWebAssets);

  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    Document(
      title: 'Tomás Sasovsky',
      lang: 'en',
      styles: [
        css.import(
          'https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,300..800;1,14..32,300..800&family=JetBrains+Mono:wght@400;500&display=swap',
        ),
        css.import('/styles.css'),
      ],
      body: ProviderScope(
        sync: [projectsFilterProvider.syncWith(kProjectsFilterSyncId)],
        child: const App(),
      ),
    ),
  );
}
