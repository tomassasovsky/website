/// The entrypoint for the **server** environment.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_riverpod/legacy.dart';

import 'api/booking_api.dart';
import 'api/contact_api.dart';
import 'api/testimonial_api.dart';
import 'app.dart';
import 'main.server.options.dart';
import 'middleware/locale_redirect_middleware.dart';
import 'middleware/serve_generated_client_js.dart';
import 'middleware/sitemap_middleware.dart';
import 'middleware/versioned_client_assets.dart';
import 'providers/projects_filter_provider.dart';

void main() {
  // Serves `/packages/...` and `/main.client*.js` from pub-cache / build output when
  // using `dart run lib/main.server.dart`. Always register (even if `JASPR_PROXY_PORT`
  // is set) so a stray env var does not skip this and break MIME types for DDC.
  ServerApp.addMiddleware(sitemapMiddleware);
  ServerApp.addMiddleware(localeRedirectMiddleware);
  ServerApp.addMiddleware(bookingApiMiddleware);
  ServerApp.addMiddleware(contactApiMiddleware);
  ServerApp.addMiddleware(testimonialApiMiddleware);
  ServerApp.addMiddleware(serveLocalDevWebAssets);

  Jaspr.initializeApp(options: versionClientAssets(defaultServerOptions));

  runApp(
    Document(
      title: 'Tomás Sasovsky',
      lang: 'en',
      styles: [
        css.import(
          'https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;450;500;550;600;650;700&family=Instrument+Serif:ital@0;1&display=swap',
        ),
        css.import('/styles.css?v=10'),
      ],
      body: ProviderScope(
        sync: [projectsFilterProvider.syncWith(kProjectsFilterSyncId)],
        child: const App(),
      ),
    ),
  );
}
