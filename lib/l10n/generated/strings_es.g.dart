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
  String get metaTitleHome => 'Sobre — Tomás Sasovsky';
  @override
  String get metaTitleProjects => 'Proyectos — Tomás Sasovsky';
  @override
  String get metaTitleContact => 'Contacto — Tomás Sasovsky';
  @override
  String get siteTagline => 'Sr. Flutter & Backend Engineer';
  @override
  String get siteLocation => 'Buenos Aires, Argentina';
  @override
  String get navAbout => 'Sobre';
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
  String get statYearsExperience => 'Años de experiencia';
  @override
  String get statProjectsShipped => 'Proyectos entregados';
  @override
  String get statContinentsServed => 'Continentes atendidos';
  @override
  String get statBugsSquashed => 'Bugs aplastados';
  @override
  String get sectionAbout => 'Acerca de mí';
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
  String get sectionTrustedBy => 'Confían en mí';
  @override
  String get sectionTestimonials => 'Testimonios';
  @override
  String get sectionWhatPeopleSay => 'Lo que dicen las personas';
  @override
  String get portfolioLabel => 'Portafolio';
  @override
  String get projectsHeading => 'Proyectos';
  @override
  String projectsSubtitle({required int projectCount}) =>
      '${projectCount} proyectos en móviles, backend y open source.';
  @override
  String get filterAll => 'Todo';
  @override
  String get filterApps => 'Aplicaciones';
  @override
  String get filterOss => 'OSS / Herramientas';
  @override
  String get projectsCtaApps => 'Ver también mis aplicaciones →';
  @override
  String get projectsCtaOss => 'Ver también mis herramientas OSS →';
  @override
  String get projectUnreleased => 'Inédito';
  @override
  String get contactGetInTouch => 'Contacto';
  @override
  String get contactHeading => 'Contacto';
  @override
  String get contactSubtitle => 'Vamos a trabajar juntos en algo genial.';
  @override
  String get contactBookTitle => 'Agenda una reunión';
  @override
  String get contactBookLine1 => 'Elige un tiempo que funcione para ti utilizando mi calendario.';
  @override
  String get contactBookLine2 =>
      'Recibirás una confirmación y un enlace de reunión de video automáticamente.';
  @override
  String get contactScheduleCall => 'Agendar una llamada →';
  @override
  String get contactOnlineTitle => 'Encontrame en línea';
  @override
  String get contactOnlineBody =>
      'Ponte en contacto directamente — siempre feliz de hablar sobre Flutter, proyectos interesantes o oportunidades nuevas.';
  @override
  String get contactFormTitle => 'Enviar un mensaje';
  @override
  String get contactFormDesc => 'Completa el formulario y te responderé en uno o dos días.';
  @override
  String get formName => 'Nombre';
  @override
  String get formNameHint => 'Tu nombre';
  @override
  String get formEmail => 'Email';
  @override
  String get formEmailHint => 'tu@email.com';
  @override
  String get formSubject => 'Asunto';
  @override
  String get formSubjectHint => '¿De qué se trata?';
  @override
  String get formMessage => 'Mensaje';
  @override
  String get formMessageHint => 'Cuéntame sobre tu proyecto, idea o simplemente saluda…';
  @override
  String get formSend => 'Enviar mensaje';
  @override
  String get formSending => 'Enviando…';
  @override
  String get formSuccess => '¡Mensaje enviado! Te responderé en breve.';
  @override
  String get formErrorGeneric => 'Algo salió mal. Por favor, inténtalo de nuevo.';
  @override
  String get formErrorRequired => 'Por favor, completa todos los campos.';
  @override
  String get formErrorEmail => 'Por favor, ingresa una dirección de email válida.';
  @override
  String footerCopyright({required int year}) => '© ${year} Tomás Sasovsky · Construido con ';
  @override
  String get langSwitchEnglish => 'EN';
  @override
  String get langSwitchSpanish => 'ES';
  @override
  String get langSwitchLabel => 'Idioma';
  @override
  String get aboutP0 =>
      'Soy un desarrollador de software full-stack con más de 5 años de experiencia profesional, especializado en el desarrollo de aplicaciones móviles multiplataforma con Flutter y Dart. He diseñado y desarrollado aplicaciones de producción de Flutter utilizadas por usuarios reales a escala en sectores financieros, deportivos y de salud.';
  @override
  String get aboutP1 =>
      'Mis fortalezas incluyen la gestión de estado (Bloc, MVVM), la arquitectura por capas de Flutter, la arquitectura limpia y las prácticas modernas de CI/CD. También cuento con sólida experiencia en backend con TypeScript/Node.js, integración de APIs (REST/GraphQL) e infraestructura en la nube (GCP/AWS). Me siento cómodo liderando equipos y proyectos, impulsando iniciativas técnicas complejas desde su concepción hasta producción, y me importa profundamente la excelencia en ingeniería, la arquitectura escalable y las experiencias de usuario excepcionales.';
  @override
  String get svc0Title => 'Desarrollo de aplicaciones móviles';
  @override
  String get svc0Desc =>
      'Diseñar y construir aplicaciones móviles de alta calidad y gran experiencia del usuario.';
  @override
  String get svc1Title => 'Desarrollo de back-end y API';
  @override
  String get svc1Desc =>
      'Servicios de TypeScript/Node.js, APIs REST, autenticación, pagos y documentación.';
  @override
  String get svc2Title => 'Aplicaciones web y front-end';
  @override
  String get svc2Desc =>
      'Interfaces web responsivas con rendimiento en mente para todos los dispositivos.';
  @override
  String get svc3Title => 'Integraciones y DevOps';
  @override
  String get svc3Desc =>
      'Integraciones de productos, monitoreo y pipelines de CI/CD para entregas confiables.';
  @override
  String get svc4Title => 'Contribuciones a código abierto';
  @override
  String get svc4Desc =>
      'Contribuyente activo a herramientas y bibliotecas de la comunidad; manteniendo y publicando proyectos de código abierto.';
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
      'Una aplicación de Stablecoin SuperApp para LATAM que ofrece una billetera en USD y un mercado de intercambio entre 70+ aplicaciones de finanzas (PayPal, Zelle, PIX, MercadoPago, Nequi, y más). Diseñado para confiabilidad y facilidad de uso para mover valor entre fronteras, proteger ahorros en USD, y habilitar flujos de trabajo de comerciantes P2P.';
  @override
  String get proj1Title => 'Aplicación SportsVisio';
  @override
  String get proj1Desc =>
      'SportsVisio entrega estadísticas de jugadores, análisis y destacados en una aplicación segura y fácil de usar, con tecnología de inteligencia artificial que lleva tu juego al siguiente nivel.';
  @override
  String get proj2Title => 'SportsVisio Manager';
  @override
  String get proj2Desc =>
      'Publica horarios y sube videos de juego. SportsVisio convierte videos de juego en estadísticas de jugadores y destacados para facilitar su revisión en la aplicación SportsVisio.';
  @override
  String get proj3Title => 'SportsVisio Track';
  @override
  String get proj3Desc =>
      'Aplicación nativa de Android experimental para el seguimiento de jugadores/bolas individuales. YOLO + MOT (Kalman + Hungarian), homografía para el mapeo del campo. Kotlin (CameraX/MediaCodec), tiempo real y bajo consumo de energía.';
  @override
  String get proj4Title => 'APIConnect';
  @override
  String get proj4Desc =>
      'Aplicación de consumo para API Abroad, construida con un stack moderno y listo para producción. Énfasis en autenticación segura, versiones confiables y una experiencia de usuario clara para guiar a los usuarios en el descubrimiento e incorporación al programa.';
  @override
  String get proj5Title => 'TAZA Express';
  @override
  String get proj5Desc =>
      'Aplicación de pedidos de comida y seguimiento de entregas para un marketplace de alto volumen. Implementé integraciones de mapas y simplifiqué los estados de pedido para una experiencia de extremo a extremo predecible.';
  @override
  String get proj6Title => 'Genjo';
  @override
  String get proj6Desc =>
      'Plataforma de inteligencia artificial diseñada para transformar visitantes en compradores, mejorar las interacciones con los clientes y generar leads. Ofrece atención al cliente personalizada las 24 horas, aumenta las conversiones y los valores promedio de pedidos, y reduce las devoluciones.';
  @override
  String get proj7Title => 'Genomii';
  @override
  String get proj7Desc =>
      'Información de salud y orientación con integraciones de dispositivos y diseño de privacidad. Responsabilidades cubiertas son las integraciones, las suscripciones y los flujos de KYC/verificación.';
  @override
  String get proj8Title => 'Guardias de Go Router';
  @override
  String get proj8Desc =>
      'Sistema de protección flexible y extensible para Go Router con lógica booleana composable y un mixin GuardedRoute. Admite combinaciones ALL/ANY/ONE-OF, redirección semántica y pruebas robustas para protecciones de rutas reutilizables.';
  @override
  String get proj9Title => 'Radio Horizon (Dart)';
  @override
  String get proj9Desc =>
      'Bot de radio que reconoce canciones actualmente en la radio. Identifica y anuncia las canciones actuales en la radio, lo que facilita el seguimiento de tus canciones favoritas.';
  @override
  String get proj10Title => 'ncnn.dart';
  @override
  String get proj10Desc =>
      'Bindings FFI de Dart y herramientas para Tencent NCNN para inferencia neuronal en dispositivo. Compatible con móvil y escritorio con buffers de copia cero donde es posible y carga pragmática de modelos. Ideal para CNNs pequeñas y rápidas sin entornos de ejecución pesados.';
  @override
  String get proj11Title => 'pytorch.dart';
  @override
  String get proj11Desc =>
      'Enlaces de Dart para la biblioteca LibTorch/PyTorch para operaciones tensoriales y ejecución de modelos. Explora superficies FFI para tensores, autograd, y invocación de modelos desde Flutter. Destinado a investigación/prototipos.';
  @override
  String get proj12Title => 'automatic_version_upgrader.dart';
  @override
  String get proj12Desc =>
      'CLI de apoyo para elevar automáticamente las versiones de Dart/Flutter y las entradas de registro de cambios. Analiza commits convencionales, actualiza pubspec, y genera entradas de registro de cambios con semántica de versión. Diseñado para adaptarse a pipelines de CI.';
  @override
  String get proj13Title => 'tus_client';
  @override
  String get proj13Desc =>
      'Cliente de Dart para el protocolo de carga de TUS para cargas de archivos grandes y redes inestables. Manipula trozos, reintentos y metadatos, y almacena la continuación de la carga entre reinicios de la aplicación. Ideal para archivos grandes y redes inestables.';
  @override
  String get proj14Title => 'radio-browser-api.dart';
  @override
  String get proj14Desc =>
      'Wrapper de Dart para la API abierta de Radio Browser para descubrir y reproducir emisoras de radio por internet. Permite buscar por nombre, país, idioma y etiqueta, con modelos tipados y una interfaz asíncrona sencilla.';
  @override
  String get testiPageTitle => 'Dejar un testimonio — Tomás Sasovsky';
  @override
  String get testiPageHeading => 'Dejar un testimonio';
  @override
  String get testiPageSubtitle =>
      'Si hemos trabajado juntos y quieres compartir algunas palabras, te lo agradecería mucho. Tu opinión ayuda a otros a entender cómo es colaborar conmigo.';
  @override
  String get testiPageExamplesTitle => 'Lo que otros han dicho';
  @override
  String get testiPageExamplesDesc =>
      'Aquí hay algunos ejemplos de compañeros y clientes anteriores — no hay un formato requerido, simplemente escribe con tus propias palabras.';
  @override
  String get testiPageFormTitle => 'Tu testimonio';
  @override
  String get testiPageFormDesc =>
      'Lo revisaré y lo agregaré al sitio si encaja bien. Una o dos oraciones están genial — un párrafo o más es aún mejor.';
  @override
  String get testiFormName => 'Tu nombre *';
  @override
  String get testiFormNameHint => 'Ana García';
  @override
  String get testiFormRole => 'Rol / Empresa';
  @override
  String get testiFormRoleHint => 'CTO en Acme Corp (opcional)';
  @override
  String get testiFormLinkedin => 'URL de perfil de LinkedIn';
  @override
  String get testiFormLinkedinHint => 'https://linkedin.com/in/tuperfil (opcional)';
  @override
  String get testiFormTestimonial => 'Tu testimonio *';
  @override
  String get testiFormTestimonialHint =>
      'Escribe libremente — unas pocas oraciones a varios párrafos está perfecto. Puedes mencionar el proyecto en el que trabajamos, lo que te llamó la atención y cualquier cosa que le dirías a alguien que esté considerando trabajar conmigo.';
  @override
  String get testiFormErrorRequired => 'Por favor, completa tu nombre y tu testimonio.';
  @override
  String get testiFormSuccess => '¡Gracias! Tu testimonio ha sido enviado y lo revisaré en breve.';
  @override
  String get testiFormSubmit => 'Enviar testimonio';
  @override
  String get testi0Date => 'Octubre 2025';
  @override
  String get testi0P0 =>
      'Me alegra recomendar a Tomás como un excelente ingeniero de software. He tenido el privilegio de trabajar junto a Tomás en IT-TechGroup y luego como líder del equipo en SportsVisio, viendo su evolución de prometedor a estrella del ingeniero.';
  @override
  String get testi0P1 =>
      'Lo que distingue a Tomás es su confiabilidad incuestionable en la entrega de soluciones de alta calidad. Su trabajo en la optimización de carga TUS en segundo plano y la reescritura de la arquitectura Bloc en SportsVisio ilustra su capacidad para enfrentar desafíos complejos y críticos.';
  @override
  String get testi0P2 =>
      'Tomás se apunta a los problemas difíciles que intimidarían a la mayoría de los ingenieros. Puedo tomar vacaciones con confianza sabiendo que manejará cualquier problema crítico. Cualquier organización estaría afortunada de tener a Tomás en sus proyectos más desafiantes.';
  @override
  String get testi1Date => 'Enero 2025';
  @override
  String get testi1P0 =>
      'Me alegra recomendar a Tomás Sasovsky como un excelente desarrollador de Flutter. Durante los últimos tres años, he tenido el placer de trabajar con Tomás como compañero de trabajo y como líder del equipo en SportsVisio, y sus contribuciones al equipo han sido invaluables.';
  @override
  String get testi1P1 =>
      'Tomás tiene profunda experiencia en Flutter y desarrollo de móviles, y siempre entrega soluciones de alta calidad. Su habilidad para resolver problemas y escribir código limpio y escalable ha llevado al éxito de numerosos proyectos.';
  @override
  String get testi1P2 =>
      'Lo que realmente lo distingue es su espíritu colaborativo y dedicación. Es un miembro de equipo natural que comparte conocimiento generosamente, enseña a los ingenieros junior y crea un ambiente de trabajo positivo.';
  @override
  String get testi2Date => 'Enero 2025';
  @override
  String get testi2P0 =>
      'Tuve el gusto de trabajar de cerca con Tomás por 2.5 años en una variedad de proyectos, incluyendo el desarrollo de una aplicación nativa de Android compleja que integraba un modelo de aprendizaje automático basado en NDK.';
  @override
  String get testi2P1 =>
      'A lo largo de nuestro tiempo trabajando juntos, demostró habilidades técnicas excepcionales, especialmente como desarrollador Flutter, y elevó nuestras capacidades en todas las capas del stack móvil.';
  @override
  String get testi2P2 =>
      'Uno de sus logros más destacados fue diseñar e implementar un pipeline de CI/CD robusto que agilizó nuestro proceso de desarrollo. Lo recomiendo firmemente a cualquier equipo que busque un desarrollador móvil talentoso y con visión de futuro.';
  @override
  String get testi3Date => 'Noviembre 2021';
  @override
  String get testi3P0 =>
      'Desarrollador proactivo y resolutivo. Si no sabe cómo hacer algo, lo busca y da resultados, siempre. Asegura la calidad del código y garantiza que lo haga.';
  @override
  String get testi4Date => 'Noviembre 2021';
  @override
  String get testi4P0 =>
      'Tomás es un ingeniero muy talentoso. Tiene un sólido conocimiento de Flutter. Es muy comprometido cuando tiene responsabilidades en un proyecto. Lo recomiendo como compañero de trabajo o líder de proyecto, ya que siempre está dispuesto a aprender más y ayudar de manera totalmente desinteresada.';
  @override
  String get exp0Title => 'Desarrollador Full-Stack — El Dorado P2P';
  @override
  String get exp0Range => 'Febrero 2025 — Septiembre 2025 · Buenos Aires (Híbrido)';
  @override
  String get exp0Desc =>
      'Diseñé y desarrollé una API pública de TypeScript para intercambios de criptomoneda en LATAM. Implementé la apertura y enlace de cuentas bancarias en EE. UU. con criptomonedas. Modularicé la aplicación de Flutter para escalabilidad y testabilidad.';
  @override
  String get exp1Title => 'Senior Flutter Engineer — SportsVisio';
  @override
  String get exp1Range => 'Enero 2022 — Febrero 2025 · Remoto (EE. UU.)';
  @override
  String get exp1Desc =>
      'Lancé SV Manager con cargas TUS en segundo plano (−30% de tiempo de carga). Implementé reproducción sincronizada de doble vista para más de 1200 usuarios mensuales. Lideré la reescritura basada en Bloc (−35% de tamaño de código). Construí el seguimiento en Android con algoritmos Kalman/Hungarian para grabación de ángulo único.';
  @override
  String get exp2Title => 'Lider técnico, Senior Flutter Engineer — VisionBox';
  @override
  String get exp2Range => 'Enero 2024 — Junio 2024 · Remoto (Canadá)';
  @override
  String get exp2Desc =>
      'Lideré un equipo de cuatro; integré Health Connect/HealthKit para información de AI. Implementé KYC con Google ML Kit, pipeline de verificación facial y suscripciones vía RevenueCat.';
  @override
  String get exp3Title => 'Ingeniero de Software (Freelance) — CourtAvenue';
  @override
  String get exp3Range => 'Julio 2023 — Septiembre 2023 · Remoto (EE. UU.)';
  @override
  String get exp3Desc =>
      'Diseñé y desarrollé Genjo (contenedor de ChatGPT de web) con Express/React; entregué ApiConnect en Flutter; herramientas internas para repositorios multi-paquete; lector de pasaportes y visas AI.';
  @override
  String get exp4Title => 'Ingeniero Flutter — Creative Advanced Technologies';
  @override
  String get exp4Range => 'Septiembre 2021 — Marzo 2022 · Remoto (Emiratos Árabes Unidos)';
  @override
  String get exp4Desc =>
      'Lancé aplicaciones de pedidos de comida y seguimiento de entregas (50K+ descargas, 4.5★). Integración de Google Maps y coordinación con el equipo de backend.';
  @override
  String get exp5Title => 'Ingeniero Flutter — It-TechGroup';
  @override
  String get exp5Range => 'Enero 2021 — Noviembre 2021 · Remoto (AR)';
  @override
  String get exp5Desc =>
      'Diseñé y desarrollé un plugin de Flutter para integrar el SDK de MercadoPago Checkout para Android/iOS (Java/Swift). Configuré CI/CD para builds y pruebas automatizadas.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppLocalizationsEs {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'metaTitleHome' => 'Sobre — Tomás Sasovsky',
      'metaTitleProjects' => 'Proyectos — Tomás Sasovsky',
      'metaTitleContact' => 'Contacto — Tomás Sasovsky',
      'siteTagline' => 'Sr. Flutter & Backend Engineer',
      'siteLocation' => 'Buenos Aires, Argentina',
      'navAbout' => 'Sobre',
      'navProjects' => 'Proyectos',
      'navContact' => 'Contacto',
      'heroBadge' => 'Disponible para nuevas oportunidades',
      'heroPrimaryCta' => 'Hablemos →',
      'heroSecondaryCta' => 'Ver mi trabajo',
      'statYearsExperience' => 'Años de experiencia',
      'statProjectsShipped' => 'Proyectos entregados',
      'statContinentsServed' => 'Continentes atendidos',
      'statBugsSquashed' => 'Bugs aplastados',
      'sectionAbout' => 'Acerca de mí',
      'sectionWhoIAm' => 'Quién soy',
      'sectionAboutSubtitle' => 'Ingeniero, constructor, contribuyente de código abierto.',
      'sectionServices' => 'Servicios',
      'sectionWhatIDo' => 'Lo que hago',
      'sectionExperience' => 'Experiencia',
      'sectionTrustedBy' => 'Confían en mí',
      'sectionTestimonials' => 'Testimonios',
      'sectionWhatPeopleSay' => 'Lo que dicen las personas',
      'portfolioLabel' => 'Portafolio',
      'projectsHeading' => 'Proyectos',
      'projectsSubtitle' =>
        ({required int projectCount}) =>
            '${projectCount} proyectos en móviles, backend y open source.',
      'filterAll' => 'Todo',
      'filterApps' => 'Aplicaciones',
      'filterOss' => 'OSS / Herramientas',
      'projectsCtaApps' => 'Ver también mis aplicaciones →',
      'projectsCtaOss' => 'Ver también mis herramientas OSS →',
      'projectUnreleased' => 'Inédito',
      'contactGetInTouch' => 'Contacto',
      'contactHeading' => 'Contacto',
      'contactSubtitle' => 'Vamos a trabajar juntos en algo genial.',
      'contactBookTitle' => 'Agenda una reunión',
      'contactBookLine1' => 'Elige un tiempo que funcione para ti utilizando mi calendario.',
      'contactBookLine2' =>
        'Recibirás una confirmación y un enlace de reunión de video automáticamente.',
      'contactScheduleCall' => 'Agendar una llamada →',
      'contactOnlineTitle' => 'Encontrame en línea',
      'contactOnlineBody' =>
        'Ponte en contacto directamente — siempre feliz de hablar sobre Flutter, proyectos interesantes o oportunidades nuevas.',
      'contactFormTitle' => 'Enviar un mensaje',
      'contactFormDesc' => 'Completa el formulario y te responderé en uno o dos días.',
      'formName' => 'Nombre',
      'formNameHint' => 'Tu nombre',
      'formEmail' => 'Email',
      'formEmailHint' => 'tu@email.com',
      'formSubject' => 'Asunto',
      'formSubjectHint' => '¿De qué se trata?',
      'formMessage' => 'Mensaje',
      'formMessageHint' => 'Cuéntame sobre tu proyecto, idea o simplemente saluda…',
      'formSend' => 'Enviar mensaje',
      'formSending' => 'Enviando…',
      'formSuccess' => '¡Mensaje enviado! Te responderé en breve.',
      'formErrorGeneric' => 'Algo salió mal. Por favor, inténtalo de nuevo.',
      'formErrorRequired' => 'Por favor, completa todos los campos.',
      'formErrorEmail' => 'Por favor, ingresa una dirección de email válida.',
      'footerCopyright' => ({required int year}) => '© ${year} Tomás Sasovsky · Construido con ',
      'langSwitchEnglish' => 'EN',
      'langSwitchSpanish' => 'ES',
      'langSwitchLabel' => 'Idioma',
      'aboutP0' =>
        'Soy un desarrollador de software full-stack con más de 5 años de experiencia profesional, especializado en el desarrollo de aplicaciones móviles multiplataforma con Flutter y Dart. He diseñado y desarrollado aplicaciones de producción de Flutter utilizadas por usuarios reales a escala en sectores financieros, deportivos y de salud.',
      'aboutP1' =>
        'Mis fortalezas incluyen la gestión de estado (Bloc, MVVM), la arquitectura por capas de Flutter, la arquitectura limpia y las prácticas modernas de CI/CD. También cuento con sólida experiencia en backend con TypeScript/Node.js, integración de APIs (REST/GraphQL) e infraestructura en la nube (GCP/AWS). Me siento cómodo liderando equipos y proyectos, impulsando iniciativas técnicas complejas desde su concepción hasta producción, y me importa profundamente la excelencia en ingeniería, la arquitectura escalable y las experiencias de usuario excepcionales.',
      'svc0Title' => 'Desarrollo de aplicaciones móviles',
      'svc0Desc' =>
        'Diseñar y construir aplicaciones móviles de alta calidad y gran experiencia del usuario.',
      'svc1Title' => 'Desarrollo de back-end y API',
      'svc1Desc' =>
        'Servicios de TypeScript/Node.js, APIs REST, autenticación, pagos y documentación.',
      'svc2Title' => 'Aplicaciones web y front-end',
      'svc2Desc' =>
        'Interfaces web responsivas con rendimiento en mente para todos los dispositivos.',
      'svc3Title' => 'Integraciones y DevOps',
      'svc3Desc' =>
        'Integraciones de productos, monitoreo y pipelines de CI/CD para entregas confiables.',
      'svc4Title' => 'Contribuciones a código abierto',
      'svc4Desc' =>
        'Contribuyente activo a herramientas y bibliotecas de la comunidad; manteniendo y publicando proyectos de código abierto.',
      'labelGooglePlay' => 'Google Play',
      'labelAppStore' => 'App Store',
      'labelWebsite' => 'Sitio web',
      'labelDocumentation' => 'Documentación',
      'labelGithub' => 'GitHub',
      'labelDiscord' => 'Discord',
      'proj0Title' => 'El Dorado P2P',
      'proj0Desc' =>
        'Una aplicación de Stablecoin SuperApp para LATAM que ofrece una billetera en USD y un mercado de intercambio entre 70+ aplicaciones de finanzas (PayPal, Zelle, PIX, MercadoPago, Nequi, y más). Diseñado para confiabilidad y facilidad de uso para mover valor entre fronteras, proteger ahorros en USD, y habilitar flujos de trabajo de comerciantes P2P.',
      'proj1Title' => 'Aplicación SportsVisio',
      'proj1Desc' =>
        'SportsVisio entrega estadísticas de jugadores, análisis y destacados en una aplicación segura y fácil de usar, con tecnología de inteligencia artificial que lleva tu juego al siguiente nivel.',
      'proj2Title' => 'SportsVisio Manager',
      'proj2Desc' =>
        'Publica horarios y sube videos de juego. SportsVisio convierte videos de juego en estadísticas de jugadores y destacados para facilitar su revisión en la aplicación SportsVisio.',
      'proj3Title' => 'SportsVisio Track',
      'proj3Desc' =>
        'Aplicación nativa de Android experimental para el seguimiento de jugadores/bolas individuales. YOLO + MOT (Kalman + Hungarian), homografía para el mapeo del campo. Kotlin (CameraX/MediaCodec), tiempo real y bajo consumo de energía.',
      'proj4Title' => 'APIConnect',
      'proj4Desc' =>
        'Aplicación de consumo para API Abroad, construida con un stack moderno y listo para producción. Énfasis en autenticación segura, versiones confiables y una experiencia de usuario clara para guiar a los usuarios en el descubrimiento e incorporación al programa.',
      'proj5Title' => 'TAZA Express',
      'proj5Desc' =>
        'Aplicación de pedidos de comida y seguimiento de entregas para un marketplace de alto volumen. Implementé integraciones de mapas y simplifiqué los estados de pedido para una experiencia de extremo a extremo predecible.',
      'proj6Title' => 'Genjo',
      'proj6Desc' =>
        'Plataforma de inteligencia artificial diseñada para transformar visitantes en compradores, mejorar las interacciones con los clientes y generar leads. Ofrece atención al cliente personalizada las 24 horas, aumenta las conversiones y los valores promedio de pedidos, y reduce las devoluciones.',
      'proj7Title' => 'Genomii',
      'proj7Desc' =>
        'Información de salud y orientación con integraciones de dispositivos y diseño de privacidad. Responsabilidades cubiertas son las integraciones, las suscripciones y los flujos de KYC/verificación.',
      'proj8Title' => 'Guardias de Go Router',
      'proj8Desc' =>
        'Sistema de protección flexible y extensible para Go Router con lógica booleana composable y un mixin GuardedRoute. Admite combinaciones ALL/ANY/ONE-OF, redirección semántica y pruebas robustas para protecciones de rutas reutilizables.',
      'proj9Title' => 'Radio Horizon (Dart)',
      'proj9Desc' =>
        'Bot de radio que reconoce canciones actualmente en la radio. Identifica y anuncia las canciones actuales en la radio, lo que facilita el seguimiento de tus canciones favoritas.',
      'proj10Title' => 'ncnn.dart',
      'proj10Desc' =>
        'Bindings FFI de Dart y herramientas para Tencent NCNN para inferencia neuronal en dispositivo. Compatible con móvil y escritorio con buffers de copia cero donde es posible y carga pragmática de modelos. Ideal para CNNs pequeñas y rápidas sin entornos de ejecución pesados.',
      'proj11Title' => 'pytorch.dart',
      'proj11Desc' =>
        'Enlaces de Dart para la biblioteca LibTorch/PyTorch para operaciones tensoriales y ejecución de modelos. Explora superficies FFI para tensores, autograd, y invocación de modelos desde Flutter. Destinado a investigación/prototipos.',
      'proj12Title' => 'automatic_version_upgrader.dart',
      'proj12Desc' =>
        'CLI de apoyo para elevar automáticamente las versiones de Dart/Flutter y las entradas de registro de cambios. Analiza commits convencionales, actualiza pubspec, y genera entradas de registro de cambios con semántica de versión. Diseñado para adaptarse a pipelines de CI.',
      'proj13Title' => 'tus_client',
      'proj13Desc' =>
        'Cliente de Dart para el protocolo de carga de TUS para cargas de archivos grandes y redes inestables. Manipula trozos, reintentos y metadatos, y almacena la continuación de la carga entre reinicios de la aplicación. Ideal para archivos grandes y redes inestables.',
      'proj14Title' => 'radio-browser-api.dart',
      'proj14Desc' =>
        'Wrapper de Dart para la API abierta de Radio Browser para descubrir y reproducir emisoras de radio por internet. Permite buscar por nombre, país, idioma y etiqueta, con modelos tipados y una interfaz asíncrona sencilla.',
      'testiPageTitle' => 'Dejar un testimonio — Tomás Sasovsky',
      'testiPageHeading' => 'Dejar un testimonio',
      'testiPageSubtitle' =>
        'Si hemos trabajado juntos y quieres compartir algunas palabras, te lo agradecería mucho. Tu opinión ayuda a otros a entender cómo es colaborar conmigo.',
      'testiPageExamplesTitle' => 'Lo que otros han dicho',
      'testiPageExamplesDesc' =>
        'Aquí hay algunos ejemplos de compañeros y clientes anteriores — no hay un formato requerido, simplemente escribe con tus propias palabras.',
      'testiPageFormTitle' => 'Tu testimonio',
      'testiPageFormDesc' =>
        'Lo revisaré y lo agregaré al sitio si encaja bien. Una o dos oraciones están genial — un párrafo o más es aún mejor.',
      'testiFormName' => 'Tu nombre *',
      'testiFormNameHint' => 'Ana García',
      'testiFormRole' => 'Rol / Empresa',
      'testiFormRoleHint' => 'CTO en Acme Corp (opcional)',
      'testiFormLinkedin' => 'URL de perfil de LinkedIn',
      'testiFormLinkedinHint' => 'https://linkedin.com/in/tuperfil (opcional)',
      'testiFormTestimonial' => 'Tu testimonio *',
      'testiFormTestimonialHint' =>
        'Escribe libremente — unas pocas oraciones a varios párrafos está perfecto. Puedes mencionar el proyecto en el que trabajamos, lo que te llamó la atención y cualquier cosa que le dirías a alguien que esté considerando trabajar conmigo.',
      'testiFormErrorRequired' => 'Por favor, completa tu nombre y tu testimonio.',
      'testiFormSuccess' => '¡Gracias! Tu testimonio ha sido enviado y lo revisaré en breve.',
      'testiFormSubmit' => 'Enviar testimonio',
      'testi0Date' => 'Octubre 2025',
      'testi0P0' =>
        'Me alegra recomendar a Tomás como un excelente ingeniero de software. He tenido el privilegio de trabajar junto a Tomás en IT-TechGroup y luego como líder del equipo en SportsVisio, viendo su evolución de prometedor a estrella del ingeniero.',
      'testi0P1' =>
        'Lo que distingue a Tomás es su confiabilidad incuestionable en la entrega de soluciones de alta calidad. Su trabajo en la optimización de carga TUS en segundo plano y la reescritura de la arquitectura Bloc en SportsVisio ilustra su capacidad para enfrentar desafíos complejos y críticos.',
      'testi0P2' =>
        'Tomás se apunta a los problemas difíciles que intimidarían a la mayoría de los ingenieros. Puedo tomar vacaciones con confianza sabiendo que manejará cualquier problema crítico. Cualquier organización estaría afortunada de tener a Tomás en sus proyectos más desafiantes.',
      'testi1Date' => 'Enero 2025',
      'testi1P0' =>
        'Me alegra recomendar a Tomás Sasovsky como un excelente desarrollador de Flutter. Durante los últimos tres años, he tenido el placer de trabajar con Tomás como compañero de trabajo y como líder del equipo en SportsVisio, y sus contribuciones al equipo han sido invaluables.',
      'testi1P1' =>
        'Tomás tiene profunda experiencia en Flutter y desarrollo de móviles, y siempre entrega soluciones de alta calidad. Su habilidad para resolver problemas y escribir código limpio y escalable ha llevado al éxito de numerosos proyectos.',
      'testi1P2' =>
        'Lo que realmente lo distingue es su espíritu colaborativo y dedicación. Es un miembro de equipo natural que comparte conocimiento generosamente, enseña a los ingenieros junior y crea un ambiente de trabajo positivo.',
      'testi2Date' => 'Enero 2025',
      'testi2P0' =>
        'Tuve el gusto de trabajar de cerca con Tomás por 2.5 años en una variedad de proyectos, incluyendo el desarrollo de una aplicación nativa de Android compleja que integraba un modelo de aprendizaje automático basado en NDK.',
      'testi2P1' =>
        'A lo largo de nuestro tiempo trabajando juntos, demostró habilidades técnicas excepcionales, especialmente como desarrollador Flutter, y elevó nuestras capacidades en todas las capas del stack móvil.',
      'testi2P2' =>
        'Uno de sus logros más destacados fue diseñar e implementar un pipeline de CI/CD robusto que agilizó nuestro proceso de desarrollo. Lo recomiendo firmemente a cualquier equipo que busque un desarrollador móvil talentoso y con visión de futuro.',
      'testi3Date' => 'Noviembre 2021',
      'testi3P0' =>
        'Desarrollador proactivo y resolutivo. Si no sabe cómo hacer algo, lo busca y da resultados, siempre. Asegura la calidad del código y garantiza que lo haga.',
      'testi4Date' => 'Noviembre 2021',
      'testi4P0' =>
        'Tomás es un ingeniero muy talentoso. Tiene un sólido conocimiento de Flutter. Es muy comprometido cuando tiene responsabilidades en un proyecto. Lo recomiendo como compañero de trabajo o líder de proyecto, ya que siempre está dispuesto a aprender más y ayudar de manera totalmente desinteresada.',
      'exp0Title' => 'Desarrollador Full-Stack — El Dorado P2P',
      'exp0Range' => 'Febrero 2025 — Septiembre 2025 · Buenos Aires (Híbrido)',
      'exp0Desc' =>
        'Diseñé y desarrollé una API pública de TypeScript para intercambios de criptomoneda en LATAM. Implementé la apertura y enlace de cuentas bancarias en EE. UU. con criptomonedas. Modularicé la aplicación de Flutter para escalabilidad y testabilidad.',
      'exp1Title' => 'Senior Flutter Engineer — SportsVisio',
      'exp1Range' => 'Enero 2022 — Febrero 2025 · Remoto (EE. UU.)',
      'exp1Desc' =>
        'Lancé SV Manager con cargas TUS en segundo plano (−30% de tiempo de carga). Implementé reproducción sincronizada de doble vista para más de 1200 usuarios mensuales. Lideré la reescritura basada en Bloc (−35% de tamaño de código). Construí el seguimiento en Android con algoritmos Kalman/Hungarian para grabación de ángulo único.',
      'exp2Title' => 'Lider técnico, Senior Flutter Engineer — VisionBox',
      'exp2Range' => 'Enero 2024 — Junio 2024 · Remoto (Canadá)',
      'exp2Desc' =>
        'Lideré un equipo de cuatro; integré Health Connect/HealthKit para información de AI. Implementé KYC con Google ML Kit, pipeline de verificación facial y suscripciones vía RevenueCat.',
      'exp3Title' => 'Ingeniero de Software (Freelance) — CourtAvenue',
      'exp3Range' => 'Julio 2023 — Septiembre 2023 · Remoto (EE. UU.)',
      'exp3Desc' =>
        'Diseñé y desarrollé Genjo (contenedor de ChatGPT de web) con Express/React; entregué ApiConnect en Flutter; herramientas internas para repositorios multi-paquete; lector de pasaportes y visas AI.',
      'exp4Title' => 'Ingeniero Flutter — Creative Advanced Technologies',
      'exp4Range' => 'Septiembre 2021 — Marzo 2022 · Remoto (Emiratos Árabes Unidos)',
      'exp4Desc' =>
        'Lancé aplicaciones de pedidos de comida y seguimiento de entregas (50K+ descargas, 4.5★). Integración de Google Maps y coordinación con el equipo de backend.',
      'exp5Title' => 'Ingeniero Flutter — It-TechGroup',
      'exp5Range' => 'Enero 2021 — Noviembre 2021 · Remoto (AR)',
      'exp5Desc' =>
        'Diseñé y desarrollé un plugin de Flutter para integrar el SDK de MercadoPago Checkout para Android/iOS (Java/Swift). Configuré CI/CD para builds y pruebas automatizadas.',
      _ => null,
    };
  }
}
