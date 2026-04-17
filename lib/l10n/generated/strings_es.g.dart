///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class AppLocalizationsEs extends AppLocalizations
    with BaseTranslations<AppLocale, AppLocalizations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  AppLocalizationsEs({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, AppLocalizations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.es,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  @override
  final TranslationMetadata<AppLocale, AppLocalizations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final AppLocalizationsEs _root = this; // ignore: unused_field

  @override
  AppLocalizationsEs $copyWith({TranslationMetadata<AppLocale, AppLocalizations>? meta}) =>
      AppLocalizationsEs(meta: meta ?? this.$meta);

  // Translations
  @override
  String get metaTitleHome => 'Acerca de — Tomás Sasovsky';
  @override
  String get metaTitleProjects => 'Proyectos — Tomás Sasovsky';
  @override
  String get metaTitleContact => 'Contacto — Tomás Sasovsky';
  @override
  String get siteTagline => 'Sr. Flutter & Backend Engineer';
  @override
  String get siteLocation => 'Buenos Aires, Argentina';
  @override
  String get navAbout => 'Acerca de';
  @override
  String get navProjects => 'Proyectos';
  @override
  String get navContact => 'Contacto';
  @override
  String get heroBadge => 'Disponible para nuevas oportunidades';
  @override
  String get heroPrimaryCta => 'Hablemos →';
  @override
  String get heroSecondaryCta => 'Ver mi trabajo';
  @override
  String get sectionAbout => 'Sobre mí';
  @override
  String get sectionWhoIAm => 'Quién soy';
  @override
  String get sectionAboutSubtitle => 'Ingeniero, constructor, contribuyente de código abierto.';
  @override
  String get sectionServices => 'Servicios';
  @override
  String get sectionWhatIDo => 'Lo que hago';
  @override
  String get sectionExperience => 'Experiencia';
  @override
  String get sectionTrustedBy => 'Confianza';
  @override
  String get sectionTestimonials => 'Testimonios';
  @override
  String get sectionWhatPeopleSay => 'Lo que dicen';
  @override
  String get portfolioLabel => 'Portfolio';
  @override
  String get projectsHeading => 'Proyectos';
  @override
  String projectsSubtitle({required int projectCount}) =>
      '${projectCount} proyectos en móvil, backend, y código abierto.';
  @override
  String get filterAll => 'Todo';
  @override
  String get filterApps => 'Aplicaciones';
  @override
  String get filterOss => 'OSS / Herramientas';
  @override
  String get projectUnreleased => 'Unreleased';
  @override
  String get contactGetInTouch => 'Estar en contacto';
  @override
  String get contactHeading => 'Contacto';
  @override
  String get contactSubtitle => '¡Let\'s work together on something great!';
  @override
  String get contactBookTitle => 'Reservar una reunión';
  @override
  String get contactBookLine1 =>
      'Seleccione un momento que funcione para ti utilizando mi calendario.';
  @override
  String get contactBookLine2 =>
      'Recibirás una confirmación y un enlace de video de reunión automáticamente.';
  @override
  String get contactScheduleCall => 'Programar una llamada →';
  @override
  String get contactOnlineTitle => 'Encuentra mi perfil en línea';
  @override
  String get contactOnlineBody =>
      'Puedes enviarme directamente — siempre feliz de charlar sobre Flutter, proyectos interesantes o nuevas oportunidades.';
  @override
  String footerCopyright({required int year}) => '© ${year} Tomás Sasovsky · Construido con ';
  @override
  String get langSwitchEnglish => 'EN';
  @override
  String get langSwitchSpanish => 'ES';
  @override
  String get langSwitchLabel => 'Lenguaje';
  @override
  String get aboutP0 =>
      'Soy un ingeniero de software con experiencia de 5+ años, especializado en el desarrollo de aplicaciones móviles multiplataforma con Flutter y Dart. He diseñado y entregado aplicaciones de producción Flutter utilizadas por usuarios reales a escala en sectores financieros, deportivos y de salud.';
  @override
  String get aboutP1 =>
      'Mis fortalezas incluyen el manejo del estado (Bloc, MVVM), la arquitectura de capas de Flutter, el manejo de la arquitectura limpia y las prácticas de CI/CD modernas. También tengo experiencia en el desarrollo de aplicaciones de backend con TypeScript/Node.js, la integración de API (REST/GraphQL) y la infraestructura en la nube (GCP/AWS). Soy capaz de liderar equipos y proyectos, dirigir iniciativas técnicas complejas desde la concepción hasta la producción y valorar la excelencia en la ingeniería, la arquitectura escalable y las experiencias de usuario excepcionales.';
  @override
  String get svc0Title => 'Desarrollo de aplicaciones móviles';
  @override
  String get svc0Desc =>
      'Diseño y construcción de aplicaciones móviles confiables y de gran usabilidad.';
  @override
  String get svc1Title => 'Desarrollo de API y servicios de backend';
  @override
  String get svc1Desc =>
      'Servicios de TypeScript/Node.js, APIs, autenticación, pagos, y documentación.';
  @override
  String get svc2Title => 'Desarrollo de aplicaciones web y frontend';
  @override
  String get svc2Desc =>
      'Interfaces web accesibles y de alta rendimiento en todos los dispositivos.';
  @override
  String get svc3Title => 'Integraciones y DevOps';
  @override
  String get svc3Desc =>
      'Integraciones de productos, monitoreo y pipelines de CI/CD para lanzamientos confiables.';
  @override
  String get svc4Title => 'Contribución a código abierto';
  @override
  String get svc4Desc =>
      'Contribuidor activo a herramientas y bibliotecas de código abierto; mantenimiento y lanzamiento de OSS.';
  @override
  String get labelGooglePlay => 'Google Play';
  @override
  String get labelAppStore => 'App Store';
  @override
  String get labelWebsite => 'Sitio web';
  @override
  String get labelDocumentation => 'Documentación';
  @override
  String get labelGithub => 'GitHub';
  @override
  String get labelDiscord => 'Discord';
  @override
  String get proj0Title => 'El Dorado P2P';
  @override
  String get proj0Desc =>
      'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.';
  @override
  String get proj1Title => 'SportsVisio App';
  @override
  String get proj1Desc =>
      'SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.';
  @override
  String get proj2Title => 'SportsVisio Manager';
  @override
  String get proj2Desc =>
      'Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.';
  @override
  String get proj3Title => 'SportsVisio Track';
  @override
  String get proj3Desc =>
      'Experimental native Android app for single-phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real-time and low power.';
  @override
  String get proj4Title => 'APIConnect';
  @override
  String get proj4Desc =>
      'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.';
  @override
  String get proj5Title => 'TAZA Express';
  @override
  String get proj5Desc =>
      'Food ordering and delivery tracking for a high-volume marketplace. Implemented map integrations and streamlined order states for a predictable end-to-end experience.';
  @override
  String get proj6Title => 'Genjo';
  @override
  String get proj6Desc =>
      'AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. Offers personalised, 24/7 customer engagement, boosting conversions and average order values while reducing returns.';
  @override
  String get proj7Title => 'Genomii';
  @override
  String get proj7Desc =>
      'Health insights and guidance with device integrations and privacy-first design. Responsibilities covered integrations, subscriptions, and KYC/verification flows.';
  @override
  String get proj8Title => 'Go Router Guards';
  @override
  String get proj8Desc =>
      'Flexible and extensible guard system for Go Router with composable boolean logic and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.';
  @override
  String get proj9Title => 'Radio Horizon (Dart)';
  @override
  String get proj9Desc =>
      'Discord radio playing bot with powerful song recognition technology. Identifies and announces songs currently playing on the radio, making it easy to keep track of your favourite tunes.';
  @override
  String get proj10Title => 'ncnn.dart';
  @override
  String get proj10Desc =>
      'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. Targets mobile and desktop with zero-copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.';
  @override
  String get proj11Title => 'pytorch.dart';
  @override
  String get proj11Desc =>
      'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping.';
  @override
  String get proj12Title => 'automatic_version_upgrader.dart';
  @override
  String get proj12Desc =>
      'CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines.';
  @override
  String get proj13Title => 'tus_client';
  @override
  String get proj13Desc =>
      'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.';
  @override
  String get testi0Date => 'Octubre 2025';
  @override
  String get testi0P0 =>
      'Me alegra recomendar a Tomás como un excelente ingeniero de software. He tenido el privilegio de trabajar junto a Tomás en IT-TechGroup y, posteriormente, como líder del equipo en SportsVisio, presenciando su evolución desde un desarrollador junior prometedor hasta un gran ingeniero.';
  @override
  String get testi0P1 =>
      'Lo que distingue a Tomás es su confiabilidad en entregar soluciones de alta calidad. Su trabajo en la optimización de cargas de TUS y la revisión de la arquitectura de Bloc en SportsVisio ilustra su capacidad para abordar desafíos complejos y de gran impacto.';
  @override
  String get testi0P2 =>
      'Tomás se ajusta a las dificultades que intimidarían a la mayoría de los ingenieros. Podía tomar vacaciones con la certeza de que manejaría cualquier problema crítico. Cualquier organización sería afortunada de tener a Tomás en sus proyectos más desafiantes.';
  @override
  String get testi1Date => 'Enero 2025';
  @override
  String get testi1P0 =>
      'Me alegra recomendar a Tomás Sasovsky como un excepcional desarrollador de Flutter. Durante los últimos tres años, he tenido el gusto de trabajar con Tomás como compañero de trabajo y como líder del equipo en SportsVisio, y sus contribuciones al equipo han sido de gran valor.';
  @override
  String get testi1P1 =>
      'Tomás trae conocimientos profundos en Flutter y desarrollo móvil, y siempre entrega aplicaciones de alta calidad. Su habilidad para resolver problemas y escribir código limpio y escalable ha llevado a cabo éxitos en numerosos proyectos.';
  @override
  String get testi1P2 =>
      'Lo que realmente lo diferencia es su espíritu colaborativo y su dedicación. Es un miembro de equipo natural que comparte conocimientos generosamente, se hace cargo de los jóvenes desarrolladores y crea un ambiente de trabajo positivo.';
  @override
  String get testi2Date => 'Enero 2025';
  @override
  String get testi2P0 =>
      'He disfrutado trabajar juntos en proyectos de variados tipos, incluyendo el desarrollo de una aplicación de Android nativa compleja que integraba un modelo de aprendizaje automático basado en NDK.';
  @override
  String get testi2P1 =>
      'A lo largo de nuestra colaboración, ha demostrado conocimientos técnicos excepcionales, especialmente en el campo del desarrollo móvil, lo que ha mejorado significativamente nuestra capacidad en cada área de la pila móvil.';
  @override
  String get testi2P2 =>
      'Una de sus logros destacados fue diseñar y implementar una canalización de CI/CD flexible y escalable que aceleró nuestro proceso de desarrollo. Te recomiendo encarecidamente como un desarrollador móvil de confianza.';
  @override
  String get testi3Date => 'Noviembre 2021';
  @override
  String get testi3P0 =>
      'Proactivo y resolutivo joven desarrollador. Si no sabe cómo hacer algo, lo busca y da resultados, siempre. Garantiza código de alta calidad y lo asegura.';
  @override
  String get testi4Date => 'Noviembre 2021';
  @override
  String get testi4P0 =>
      'Tomás es un joven muy talentoso. Tiene conocimientos sólidos de Flutter. Es muy comprometido cuando tiene responsabilidades de proyecto. Te recomiendo como compañero de trabajo o líder de proyecto, ya que siempre está dispuesto a aprender más y ayudar de manera totalmente autosuficiente.';
  @override
  String get exp0Title => 'Desarrollador de software Full Stack — El Dorado P2P';
  @override
  String get exp0Range => 'Feb 2025 — Sep 2025 · Buenos Aires (Híbrido)';
  @override
  String get exp0Desc =>
      'Diseñé una API pública de TypeScript para intercambios de criptomonedas en Latinoamérica. Implementé la apertura de cuentas bancarias en USD y el enlace de crypto wallets. Modularicé la aplicación de Flutter para escalabilidad y fiabilidad.';
  @override
  String get exp1Title => 'Ingeniero Flutter Senior — SportsVisio';
  @override
  String get exp1Range => 'Jan 2022 — Feb 2025 · Remoto (EE.UU.)';
  @override
  String get exp1Desc =>
      'Entregué SV Manager con carga de fondo TUS para subidas de archivos (−30% tiempo de subida). Implementé la sincronización de reproducción dual para 1200+ usuarios al mes. Líder de la reescritura de Bloc (−35% tamaño del código). Implementé la detección de rostros con algoritmos de Kalman/Hungarian para la grabación de ángulo único.';
  @override
  String get exp2Title => 'Lider de equipo, Ingeniero Flutter Senior — VisionBox';
  @override
  String get exp2Range => 'Jan 2024 — Jun 2024 · Remoto (Canadá)';
  @override
  String get exp2Desc =>
      'Led a team of four; implemented Health Connect/HealthKit for AI insights. Implemented KYC with Google ML Kit; Face verification pipeline; Subscriptions via RevenueCat.';
  @override
  String get exp3Title => 'Ingeniero de software (prácticas) — CourtAvenue';
  @override
  String get exp3Range => 'Jul 2023 — Sep 2023 · Remoto (EE.UU.)';
  @override
  String get exp3Desc =>
      'Build Genjo (wrapper de ChatGPT para web) con Express/React; entregado ApiConnect en Flutter; herramientas internas para repositorios múltiples; lector de pasaportes/visas AI-driven.';
  @override
  String get exp4Title => 'Ingeniero Flutter — Creative Advanced Technologies';
  @override
  String get exp4Range => 'Sep 2021 — Mar 2022 · Remoto (Emiratos Árabes Unidos)';
  @override
  String get exp4Desc =>
      'Lanzé aplicaciones de pedido y seguimiento de envíos de alimentos (50K+ descargas, 4.5★). Integración de Google Maps y coordinación de backend.';
  @override
  String get exp5Title => 'Ingeniero Flutter — It-TechGroup';
  @override
  String get exp5Range => 'Jan 2021 — Nov 2021 · Remoto (Argentina)';
  @override
  String get exp5Desc =>
      'Build a Flutter plugin to integrate MercadoPago Checkout SDK for Android/iOS (Java/Swift). Set up CI/CD for automated builds and tests.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppLocalizationsEs {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'metaTitleHome' => 'Acerca de — Tomás Sasovsky',
      'metaTitleProjects' => 'Proyectos — Tomás Sasovsky',
      'metaTitleContact' => 'Contacto — Tomás Sasovsky',
      'siteTagline' => 'Sr. Flutter & Backend Engineer',
      'siteLocation' => 'Buenos Aires, Argentina',
      'navAbout' => 'Acerca de',
      'navProjects' => 'Proyectos',
      'navContact' => 'Contacto',
      'heroBadge' => 'Disponible para nuevas oportunidades',
      'heroPrimaryCta' => 'Hablemos →',
      'heroSecondaryCta' => 'Ver mi trabajo',
      'sectionAbout' => 'Sobre mí',
      'sectionWhoIAm' => 'Quién soy',
      'sectionAboutSubtitle' => 'Ingeniero, constructor, contribuyente de código abierto.',
      'sectionServices' => 'Servicios',
      'sectionWhatIDo' => 'Lo que hago',
      'sectionExperience' => 'Experiencia',
      'sectionTrustedBy' => 'Confianza',
      'sectionTestimonials' => 'Testimonios',
      'sectionWhatPeopleSay' => 'Lo que dicen',
      'portfolioLabel' => 'Portfolio',
      'projectsHeading' => 'Proyectos',
      'projectsSubtitle' =>
        ({required int projectCount}) =>
            '${projectCount} proyectos en móvil, backend, y código abierto.',
      'filterAll' => 'Todo',
      'filterApps' => 'Aplicaciones',
      'filterOss' => 'OSS / Herramientas',
      'projectUnreleased' => 'Unreleased',
      'contactGetInTouch' => 'Estar en contacto',
      'contactHeading' => 'Contacto',
      'contactSubtitle' => '¡Let\'s work together on something great!',
      'contactBookTitle' => 'Reservar una reunión',
      'contactBookLine1' => 'Seleccione un momento que funcione para ti utilizando mi calendario.',
      'contactBookLine2' =>
        'Recibirás una confirmación y un enlace de video de reunión automáticamente.',
      'contactScheduleCall' => 'Programar una llamada →',
      'contactOnlineTitle' => 'Encuentra mi perfil en línea',
      'contactOnlineBody' =>
        'Puedes enviarme directamente — siempre feliz de charlar sobre Flutter, proyectos interesantes o nuevas oportunidades.',
      'footerCopyright' => ({required int year}) => '© ${year} Tomás Sasovsky · Construido con ',
      'langSwitchEnglish' => 'EN',
      'langSwitchSpanish' => 'ES',
      'langSwitchLabel' => 'Lenguaje',
      'aboutP0' =>
        'Soy un ingeniero de software con experiencia de 5+ años, especializado en el desarrollo de aplicaciones móviles multiplataforma con Flutter y Dart. He diseñado y entregado aplicaciones de producción Flutter utilizadas por usuarios reales a escala en sectores financieros, deportivos y de salud.',
      'aboutP1' =>
        'Mis fortalezas incluyen el manejo del estado (Bloc, MVVM), la arquitectura de capas de Flutter, el manejo de la arquitectura limpia y las prácticas de CI/CD modernas. También tengo experiencia en el desarrollo de aplicaciones de backend con TypeScript/Node.js, la integración de API (REST/GraphQL) y la infraestructura en la nube (GCP/AWS). Soy capaz de liderar equipos y proyectos, dirigir iniciativas técnicas complejas desde la concepción hasta la producción y valorar la excelencia en la ingeniería, la arquitectura escalable y las experiencias de usuario excepcionales.',
      'svc0Title' => 'Desarrollo de aplicaciones móviles',
      'svc0Desc' =>
        'Diseño y construcción de aplicaciones móviles confiables y de gran usabilidad.',
      'svc1Title' => 'Desarrollo de API y servicios de backend',
      'svc1Desc' => 'Servicios de TypeScript/Node.js, APIs, autenticación, pagos, y documentación.',
      'svc2Title' => 'Desarrollo de aplicaciones web y frontend',
      'svc2Desc' => 'Interfaces web accesibles y de alta rendimiento en todos los dispositivos.',
      'svc3Title' => 'Integraciones y DevOps',
      'svc3Desc' =>
        'Integraciones de productos, monitoreo y pipelines de CI/CD para lanzamientos confiables.',
      'svc4Title' => 'Contribución a código abierto',
      'svc4Desc' =>
        'Contribuidor activo a herramientas y bibliotecas de código abierto; mantenimiento y lanzamiento de OSS.',
      'labelGooglePlay' => 'Google Play',
      'labelAppStore' => 'App Store',
      'labelWebsite' => 'Sitio web',
      'labelDocumentation' => 'Documentación',
      'labelGithub' => 'GitHub',
      'labelDiscord' => 'Discord',
      'proj0Title' => 'El Dorado P2P',
      'proj0Desc' =>
        'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.',
      'proj1Title' => 'SportsVisio App',
      'proj1Desc' =>
        'SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.',
      'proj2Title' => 'SportsVisio Manager',
      'proj2Desc' =>
        'Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.',
      'proj3Title' => 'SportsVisio Track',
      'proj3Desc' =>
        'Experimental native Android app for single-phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real-time and low power.',
      'proj4Title' => 'APIConnect',
      'proj4Desc' =>
        'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.',
      'proj5Title' => 'TAZA Express',
      'proj5Desc' =>
        'Food ordering and delivery tracking for a high-volume marketplace. Implemented map integrations and streamlined order states for a predictable end-to-end experience.',
      'proj6Title' => 'Genjo',
      'proj6Desc' =>
        'AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. Offers personalised, 24/7 customer engagement, boosting conversions and average order values while reducing returns.',
      'proj7Title' => 'Genomii',
      'proj7Desc' =>
        'Health insights and guidance with device integrations and privacy-first design. Responsibilities covered integrations, subscriptions, and KYC/verification flows.',
      'proj8Title' => 'Go Router Guards',
      'proj8Desc' =>
        'Flexible and extensible guard system for Go Router with composable boolean logic and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.',
      'proj9Title' => 'Radio Horizon (Dart)',
      'proj9Desc' =>
        'Discord radio playing bot with powerful song recognition technology. Identifies and announces songs currently playing on the radio, making it easy to keep track of your favourite tunes.',
      'proj10Title' => 'ncnn.dart',
      'proj10Desc' =>
        'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. Targets mobile and desktop with zero-copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.',
      'proj11Title' => 'pytorch.dart',
      'proj11Desc' =>
        'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping.',
      'proj12Title' => 'automatic_version_upgrader.dart',
      'proj12Desc' =>
        'CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines.',
      'proj13Title' => 'tus_client',
      'proj13Desc' =>
        'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.',
      'testi0Date' => 'Octubre 2025',
      'testi0P0' =>
        'Me alegra recomendar a Tomás como un excelente ingeniero de software. He tenido el privilegio de trabajar junto a Tomás en IT-TechGroup y, posteriormente, como líder del equipo en SportsVisio, presenciando su evolución desde un desarrollador junior prometedor hasta un gran ingeniero.',
      'testi0P1' =>
        'Lo que distingue a Tomás es su confiabilidad en entregar soluciones de alta calidad. Su trabajo en la optimización de cargas de TUS y la revisión de la arquitectura de Bloc en SportsVisio ilustra su capacidad para abordar desafíos complejos y de gran impacto.',
      'testi0P2' =>
        'Tomás se ajusta a las dificultades que intimidarían a la mayoría de los ingenieros. Podía tomar vacaciones con la certeza de que manejaría cualquier problema crítico. Cualquier organización sería afortunada de tener a Tomás en sus proyectos más desafiantes.',
      'testi1Date' => 'Enero 2025',
      'testi1P0' =>
        'Me alegra recomendar a Tomás Sasovsky como un excepcional desarrollador de Flutter. Durante los últimos tres años, he tenido el gusto de trabajar con Tomás como compañero de trabajo y como líder del equipo en SportsVisio, y sus contribuciones al equipo han sido de gran valor.',
      'testi1P1' =>
        'Tomás trae conocimientos profundos en Flutter y desarrollo móvil, y siempre entrega aplicaciones de alta calidad. Su habilidad para resolver problemas y escribir código limpio y escalable ha llevado a cabo éxitos en numerosos proyectos.',
      'testi1P2' =>
        'Lo que realmente lo diferencia es su espíritu colaborativo y su dedicación. Es un miembro de equipo natural que comparte conocimientos generosamente, se hace cargo de los jóvenes desarrolladores y crea un ambiente de trabajo positivo.',
      'testi2Date' => 'Enero 2025',
      'testi2P0' =>
        'He disfrutado trabajar juntos en proyectos de variados tipos, incluyendo el desarrollo de una aplicación de Android nativa compleja que integraba un modelo de aprendizaje automático basado en NDK.',
      'testi2P1' =>
        'A lo largo de nuestra colaboración, ha demostrado conocimientos técnicos excepcionales, especialmente en el campo del desarrollo móvil, lo que ha mejorado significativamente nuestra capacidad en cada área de la pila móvil.',
      'testi2P2' =>
        'Una de sus logros destacados fue diseñar y implementar una canalización de CI/CD flexible y escalable que aceleró nuestro proceso de desarrollo. Te recomiendo encarecidamente como un desarrollador móvil de confianza.',
      'testi3Date' => 'Noviembre 2021',
      'testi3P0' =>
        'Proactivo y resolutivo joven desarrollador. Si no sabe cómo hacer algo, lo busca y da resultados, siempre. Garantiza código de alta calidad y lo asegura.',
      'testi4Date' => 'Noviembre 2021',
      'testi4P0' =>
        'Tomás es un joven muy talentoso. Tiene conocimientos sólidos de Flutter. Es muy comprometido cuando tiene responsabilidades de proyecto. Te recomiendo como compañero de trabajo o líder de proyecto, ya que siempre está dispuesto a aprender más y ayudar de manera totalmente autosuficiente.',
      'exp0Title' => 'Desarrollador de software Full Stack — El Dorado P2P',
      'exp0Range' => 'Feb 2025 — Sep 2025 · Buenos Aires (Híbrido)',
      'exp0Desc' =>
        'Diseñé una API pública de TypeScript para intercambios de criptomonedas en Latinoamérica. Implementé la apertura de cuentas bancarias en USD y el enlace de crypto wallets. Modularicé la aplicación de Flutter para escalabilidad y fiabilidad.',
      'exp1Title' => 'Ingeniero Flutter Senior — SportsVisio',
      'exp1Range' => 'Jan 2022 — Feb 2025 · Remoto (EE.UU.)',
      'exp1Desc' =>
        'Entregué SV Manager con carga de fondo TUS para subidas de archivos (−30% tiempo de subida). Implementé la sincronización de reproducción dual para 1200+ usuarios al mes. Líder de la reescritura de Bloc (−35% tamaño del código). Implementé la detección de rostros con algoritmos de Kalman/Hungarian para la grabación de ángulo único.',
      'exp2Title' => 'Lider de equipo, Ingeniero Flutter Senior — VisionBox',
      'exp2Range' => 'Jan 2024 — Jun 2024 · Remoto (Canadá)',
      'exp2Desc' =>
        'Led a team of four; implemented Health Connect/HealthKit for AI insights. Implemented KYC with Google ML Kit; Face verification pipeline; Subscriptions via RevenueCat.',
      'exp3Title' => 'Ingeniero de software (prácticas) — CourtAvenue',
      'exp3Range' => 'Jul 2023 — Sep 2023 · Remoto (EE.UU.)',
      'exp3Desc' =>
        'Build Genjo (wrapper de ChatGPT para web) con Express/React; entregado ApiConnect en Flutter; herramientas internas para repositorios múltiples; lector de pasaportes/visas AI-driven.',
      'exp4Title' => 'Ingeniero Flutter — Creative Advanced Technologies',
      'exp4Range' => 'Sep 2021 — Mar 2022 · Remoto (Emiratos Árabes Unidos)',
      'exp4Desc' =>
        'Lanzé aplicaciones de pedido y seguimiento de envíos de alimentos (50K+ descargas, 4.5★). Integración de Google Maps y coordinación de backend.',
      'exp5Title' => 'Ingeniero Flutter — It-TechGroup',
      'exp5Range' => 'Jan 2021 — Nov 2021 · Remoto (Argentina)',
      'exp5Desc' =>
        'Build a Flutter plugin to integrate MercadoPago Checkout SDK for Android/iOS (Java/Swift). Set up CI/CD for automated builds and tests.',
      _ => null,
    };
  }
}
