// ignore_for_file: avoid_print

/// Regenerates `lib/l10n/arb/en.arb` and `es.arb` from the maps below (proper JSON escaping).
///
/// Workflow:
/// 1. Edit the string maps in this file (or edit the `.arb` files directly).
/// 2. `dart run tool/emit_portfolio_arb.dart` — only needed if you changed this file’s maps.
/// 3. `dart run slang` — updates `lib/l10n/generated/`.
///
/// If you maintain `.arb` by hand, do not run this script afterward (it overwrites those files)
/// unless you also update the maps here to match.
library;

import 'dart:convert';
import 'dart:io';

void main() {
  final root = Directory.current.path;
  File('$root/lib/l10n/arb/en.arb').writeAsStringSync(_json(_en));
  File('$root/lib/l10n/arb/es.arb').writeAsStringSync(_json(_es));
  print('Wrote lib/l10n/arb/en.arb and es.arb');
}

String _json(Map<String, dynamic> m) => const JsonEncoder.withIndent('  ').convert(m);

Map<String, dynamic> get _en => {
  '@@locale': 'en',
  ..._uiEn,
  ..._aboutEn,
  ..._svcEn,
  ..._labelsEn,
  ..._projEn,
  ..._testiEn,
  ..._expEn,
};

Map<String, dynamic> get _es => {
  '@@locale': 'es',
  ..._uiEs,
  ..._aboutEs,
  ..._svcEs,
  ..._labelsEs,
  ..._projEs,
  ..._testiEs,
  ..._expEs,
};

// —— UI (existing keys; keep in sync with prior arb) ————————————————
const _uiEn = {
  'metaTitleHome': 'About — Tomás Sasovsky',
  'metaTitleProjects': 'Projects — Tomás Sasovsky',
  'metaTitleContact': 'Contact — Tomás Sasovsky',
  'siteTagline': 'Sr. Flutter & Backend Engineer',
  'siteLocation': 'Buenos Aires, Argentina',
  'navAbout': 'About',
  'navProjects': 'Projects',
  'navContact': 'Contact',
  'heroBadge': 'Available for new opportunities',
  'heroPrimaryCta': "Let's talk →",
  'heroSecondaryCta': 'See my work',
  'sectionAbout': 'About me',
  'sectionWhoIAm': 'Who I am',
  'sectionAboutSubtitle': 'Engineer, builder, open-source contributor.',
  'sectionServices': 'Services',
  'sectionWhatIDo': 'What I do',
  'sectionExperience': 'Experience',
  'sectionTrustedBy': 'Trusted by',
  'sectionTestimonials': 'Testimonials',
  'sectionWhatPeopleSay': 'What people say',
  'portfolioLabel': 'Portfolio',
  'projectsHeading': 'Projects',
  'projectsSubtitle': '{projectCount} projects across mobile, backend, and open source.',
  '@projectsSubtitle': {
    'placeholders': {
      'projectCount': {'type': 'int'},
    },
  },
  'filterAll': 'All',
  'filterApps': 'Apps',
  'filterOss': 'OSS / Tools',
  'projectUnreleased': 'Unreleased',
  'contactGetInTouch': 'Get in touch',
  'contactHeading': 'Contact',
  'contactSubtitle': "Let's work together on something great.",
  'contactBookTitle': 'Book a meeting',
  'contactBookLine1': 'Pick a time that works for you using my calendar.',
  'contactBookLine2': "You'll get a confirmation and a video meeting link automatically.",
  'contactScheduleCall': 'Schedule a call →',
  'contactOnlineTitle': 'Find me online',
  'contactOnlineBody':
      'Reach out directly — always happy to chat about Flutter, interesting projects, or new opportunities.',
  'footerCopyright': '© {year} Tomás Sasovsky · Built with ',
  '@footerCopyright': {
    'placeholders': {
      'year': {'type': 'int'},
    },
  },
  'langSwitchEnglish': 'EN',
  'langSwitchSpanish': 'ES',
  'langSwitchLabel': 'Language',
};

const _uiEs = {
  'metaTitleHome': 'Sobre mí — Tomás Sasovsky',
  'metaTitleProjects': 'Proyectos — Tomás Sasovsky',
  'metaTitleContact': 'Contacto — Tomás Sasovsky',
  'siteTagline': 'Ing. senior Flutter y backend',
  'siteLocation': 'Buenos Aires, Argentina',
  'navAbout': 'Sobre mí',
  'navProjects': 'Proyectos',
  'navContact': 'Contacto',
  'heroBadge': 'Disponible para nuevas oportunidades',
  'heroPrimaryCta': 'Hablemos →',
  'heroSecondaryCta': 'Ver mi trabajo',
  'sectionAbout': 'Sobre mí',
  'sectionWhoIAm': 'Quién soy',
  'sectionAboutSubtitle': 'Ingeniero, builder y contribuidor open source.',
  'sectionServices': 'Servicios',
  'sectionWhatIDo': 'Qué hago',
  'sectionExperience': 'Experiencia',
  'sectionTrustedBy': 'Confían en mí',
  'sectionTestimonials': 'Referencias',
  'sectionWhatPeopleSay': 'Qué dicen',
  'portfolioLabel': 'Portafolio',
  'projectsHeading': 'Proyectos',
  'projectsSubtitle': '{projectCount} proyectos en mobile, backend y código abierto.',
  '@projectsSubtitle': {
    'placeholders': {
      'projectCount': {'type': 'int'},
    },
  },
  'filterAll': 'Todos',
  'filterApps': 'Apps',
  'filterOss': 'OSS / Herramientas',
  'projectUnreleased': 'No publicado',
  'contactGetInTouch': 'Contacto',
  'contactHeading': 'Contacto',
  'contactSubtitle': 'Trabajemos juntos en algo genial.',
  'contactBookTitle': 'Agendar una reunión',
  'contactBookLine1': 'Elegí un horario en mi calendario.',
  'contactBookLine2': 'Vas a recibir la confirmación y el enlace de videollamada automáticamente.',
  'contactScheduleCall': 'Agendar llamada →',
  'contactOnlineTitle': 'Encontrame online',
  'contactOnlineBody':
      'Escribime directamente: siempre encantado de hablar de Flutter, proyectos interesantes u oportunidades nuevas.',
  'footerCopyright': '© {year} Tomás Sasovsky · Hecho con ',
  '@footerCopyright': {
    'placeholders': {
      'year': {'type': 'int'},
    },
  },
  'langSwitchEnglish': 'EN',
  'langSwitchSpanish': 'ES',
  'langSwitchLabel': 'Idioma',
};

const _aboutEn = {
  'aboutP0':
      "I'm a full-stack software engineer with 5+ years of professional experience, specialising in cross-platform mobile development with Flutter and Dart. I've architected and delivered production Flutter applications used by real users at scale across fintech, sports tech, and health sectors.",
  'aboutP1':
      'My strengths include state management (Bloc, MVVM), Flutter layered architecture, clean architecture, and modern CI/CD practices. I also bring strong backend experience with TypeScript/Node.js, API integration (REST/GraphQL), and cloud infrastructure (GCP/AWS). I\'m comfortable leading teams and projects, driving complex technical initiatives from concept to production, and I care deeply about engineering excellence, scalable architecture, and exceptional user experiences.',
};

const _aboutEs = {
  'aboutP0':
      'Soy ingeniero de software full-stack con más de 5 años de experiencia, especializado en desarrollo mobile multiplataforma con Flutter y Dart. Diseñé y entregué aplicaciones Flutter en producción, usadas a escala en fintech, deportes y salud.',
  'aboutP1':
      'Mis fortalezas incluyen gestión de estado (Bloc, MVVM), arquitectura por capas en Flutter, clean architecture y CI/CD moderno. También tengo sólida experiencia backend con TypeScript/Node.js, integración de APIs (REST/GraphQL) e infraestructura en la nube (GCP/AWS). Me gusta liderar equipos e iniciativas técnicas de punta a punta, con foco en excelencia de ingeniería, arquitectura escalable y experiencias de usuario excepcionales.',
};

const _svcEn = {
  'svc0Title': 'Mobile app development',
  'svc0Desc': 'Design and build reliable iOS/Android apps with modern architecture and great UX.',
  'svc1Title': 'Backend & API development',
  'svc1Desc': 'TypeScript/Node.js services, REST APIs, authentication, payments, and docs.',
  'svc2Title': 'Web apps & front-end',
  'svc2Desc': 'Responsive, accessible interfaces with performance in mind across all devices.',
  'svc3Title': 'Integrations & DevOps',
  'svc3Desc': 'Product integrations, monitoring, and CI/CD pipelines for dependable releases.',
  'svc4Title': 'Open source contributions',
  'svc4Desc': 'Active contributor to community tools and libraries; maintaining and shipping OSS.',
};

const _svcEs = {
  'svc0Title': 'Desarrollo de apps mobile',
  'svc0Desc': 'Diseño y construcción de apps iOS/Android confiables, con arquitectura moderna y buena UX.',
  'svc1Title': 'Backend y APIs',
  'svc1Desc': 'Servicios TypeScript/Node.js, APIs REST, autenticación, pagos y documentación.',
  'svc2Title': 'Web y front-end',
  'svc2Desc': 'Interfaces responsivas y accesibles, con foco en rendimiento en todos los dispositivos.',
  'svc3Title': 'Integraciones y DevOps',
  'svc3Desc': 'Integraciones de producto, monitoreo y pipelines CI/CD para releases estables.',
  'svc4Title': 'Contribuciones open source',
  'svc4Desc': 'Contribución activa a herramientas y librerías de la comunidad; mantenimiento y releases OSS.',
};

const _labelsEn = {
  'labelGooglePlay': 'Google Play',
  'labelAppStore': 'App Store',
  'labelWebsite': 'Website',
  'labelDocumentation': 'Documentation',
  'labelGithub': 'GitHub',
  'labelDiscord': 'Discord',
};

const _labelsEs = {
  'labelGooglePlay': 'Google Play',
  'labelAppStore': 'App Store',
  'labelWebsite': 'Sitio web',
  'labelDocumentation': 'Documentación',
  'labelGithub': 'GitHub',
  'labelDiscord': 'Discord',
};

// Projects 0–14 (titles + descriptions) — English
const _projEn = {
  'proj0Title': 'El Dorado P2P',
  'proj0Desc':
      'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.',
  'proj1Title': 'SportsVisio App',
  'proj1Desc':
      'SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.',
  'proj2Title': 'SportsVisio Manager',
  'proj2Desc':
      'Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.',
  'proj3Title': 'SportsVisio Track',
  'proj3Desc':
      'Experimental native Android app for single-phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real-time and low power.',
  'proj4Title': 'APIConnect',
  'proj4Desc':
      'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.',
  'proj5Title': 'TAZA Express',
  'proj5Desc':
      'Food ordering and delivery tracking for a high-volume marketplace. Implemented map integrations and streamlined order states for a predictable end-to-end experience.',
  'proj6Title': 'Genjo',
  'proj6Desc':
      'AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. Offers personalised, 24/7 customer engagement, boosting conversions and average order values while reducing returns.',
  'proj7Title': 'Genomii',
  'proj7Desc':
      'Health insights and guidance with device integrations and privacy-first design. Responsibilities covered integrations, subscriptions, and KYC/verification flows.',
  'proj8Title': 'Go Router Guards',
  'proj8Desc':
      'Flexible and extensible guard system for Go Router with composable boolean logic and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.',
  'proj9Title': 'Radio Horizon (Dart)',
  'proj9Desc':
      'Discord radio playing bot with powerful song recognition technology. Identifies and announces songs currently playing on the radio, making it easy to keep track of your favourite tunes.',
  'proj10Title': 'ncnn.dart',
  'proj10Desc':
      'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. Targets mobile and desktop with zero-copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.',
  'proj11Title': 'pytorch.dart',
  'proj11Desc':
      'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping.',
  'proj12Title': 'automatic_version_upgrader.dart',
  'proj12Desc':
      'CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines.',
  'proj13Title': 'tus_client',
  'proj13Desc':
      'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.',
};

const _projEs = {
  'proj0Title': 'El Dorado P2P',
  'proj0Desc':
      'SuperApp de stablecoins para LATAM con billetera en USD y mercado P2P integrado a +70 apps financieras (PayPal, Zelle, PIX, MercadoPago, Nequi y más). Pensada para confiabilidad y facilidad: mover valor entre fronteras, proteger ahorros en USD y flujos comerciales P2P.',
  'proj1Title': 'SportsVisio App',
  'proj1Desc':
      'SportsVisio ofrece estadísticas, análisis y highlights en una app segura y simple, con tecnología de IA para llevar tu juego al siguiente nivel.',
  'proj2Title': 'SportsVisio Manager',
  'proj2Desc':
      'Publicá agendas y subí video del partido. SportsVisio convierte el material en estadísticas y highlights para revisar en la app SportsVisio.',
  'proj3Title': 'SportsVisio Track',
  'proj3Desc':
      'App Android nativa experimental para tracking de jugador/pelota con un solo teléfono. YOLO + MOT (Kalman + Hungarian), homografía para la cancha. Kotlin (CameraX/MediaCodec), tiempo real y bajo consumo.',
  'proj4Title': 'APIConnect',
  'proj4Desc':
      'App de consumo para API Abroad, con stack moderno y CI/CD listo para producción. Énfasis en auth segura, releases estables y UX clara para descubrimiento de programas y onboarding.',
  'proj5Title': 'TAZA Express',
  'proj5Desc':
      'Pedidos de comida y seguimiento de envíos para un marketplace de alto volumen. Integraciones de mapas y estados de pedido claros de punta a punta.',
  'proj6Title': 'Genjo',
  'proj6Desc':
      'Plataforma con IA para convertir navegación en compras, mejorar la atención y generar leads, con engagement 24/7 personalizado y foco en conversión.',
  'proj7Title': 'Genomii',
  'proj7Desc':
      'Insights de salud y guía con integraciones de dispositivos y diseño privacy-first. Integraciones, suscripciones y flujos KYC/verificación.',
  'proj8Title': 'Go Router Guards',
  'proj8Desc':
      'Sistema de guards extensible para Go Router con lógica booleana composable y rutas tipadas. Soporta combinaciones ALL/ANY/ONE-OF, redirects y mixin GuardedRoute. Incluye ejemplos y tests para protección reutilizable.',
  'proj9Title': 'Radio Horizon (Dart)',
  'proj9Desc':
      'Bot de Discord para radio con reconocimiento musical. Identifica y anuncia lo que suena, facilitando seguir tus canciones favoritas.',
  'proj10Title': 'ncnn.dart',
  'proj10Desc':
      'Bindings Dart FFI y tooling sobre Tencent NCNN para inferencia neuronal on-device. Mobile y desktop con buffers zero-copy cuando se puede y carga de modelos pragmática. Útil para CNNs livianas sin runtimes pesados.',
  'proj11Title': 'pytorch.dart',
  'proj11Desc':
      'Bindings experimentales Dart para LibTorch/PyTorch: tensores y ejecución de modelos nativa. Explora FFI para tensores, autograd e invocación desde Flutter; orientado a investigación y prototipos.',
  'proj12Title': 'automatic_version_upgrader.dart',
  'proj12Desc':
      'CLI para bump automático de versiones y changelogs en paquetes Dart/Flutter. Parsea conventional commits, actualiza pubspec y genera entradas con versionado semántico; pensado para CI.',
  'proj13Title': 'tus_client',
  'proj13Desc':
      'Cliente Dart para el protocolo TUS de subidas reanudables: subidas fiables con reintentos, chunks y metadatos, con almacenamiento enchufable para retomar tras reinicios. Ideal para archivos grandes y redes inestables.',
};

const _testiEn = {
  'testi0Date': 'October 2025',
  'testi0P0':
      "I'm excited to recommend Tomás as an outstanding software engineer. I've had the unique privilege of working alongside Tomás at IT-TechGroup and later leading him as Team Lead at SportsVisio, witnessing his remarkable evolution from promising junior developer to all-star engineer.",
  'testi0P1':
      'What distinguishes Tomás is his unwavering reliability in delivering high-quality solutions. His work on background TUS upload optimization and Bloc-based architecture rewrite at SportsVisio exemplifies his ability to tackle complex, high-impact challenges.',
  'testi0P2':
      "Tomás thrives on difficult problems that would intimidate most engineers. I could confidently take holidays knowing he'd handle any critical issue. Any organisation would be fortunate to have Tomás on their most challenging projects.",
  'testi1Date': 'January 2025',
  'testi1P0':
      'I am thrilled to recommend Tomás Sasovsky as an exceptional Flutter Developer. Over the past three years, I\'ve had the pleasure of working with Tomás as both a coworker and his team lead, and his contributions to our team have been invaluable.',
  'testi1P1':
      'Tomás brings deep expertise in Flutter and mobile development, consistently delivering high-quality applications. His problem-solving skills and ability to write clean, scalable code have driven the success of numerous projects.',
  'testi1P2':
      'What truly sets Tomás apart is his collaborative spirit and dedication. He is a natural team player who shares knowledge generously, mentors junior developers, and fosters a positive work environment.',
  'testi2Date': 'January 2025',
  'testi2P0':
      'I had the pleasure of working closely with Tomás for 2.5 years on a variety of projects, including the development of a complex Android native app that integrated an NDK-based machine learning model.',
  'testi2P1':
      'Throughout our time working together, he demonstrated exceptional technical expertise, particularly as a mobile Flutter developer, where his contributions elevated our capabilities in every area of the mobile stack.',
  'testi2P2':
      'One of his standout accomplishments was designing and implementing a robust CI/CD pipeline that streamlined our development process. I strongly recommend him to any team looking for a talented, forward-thinking mobile developer.',
  'testi3Date': 'November 2021',
  'testi3P0':
      "Proactive and resolutive young developer. If he doesn't know how to do something he finds it out and gives results, always. He ensures to perform quality code and guarantees you for that.",
  'testi4Date': 'November 2021',
  'testi4P0':
      'Tomás is a very talented young man. He has a solid knowledge of Flutter. He is very committed when he has project responsibilities. I recommend him as a co-worker or project leader, since he is always willing to learn more and help in a totally selfless way.',
};

const _testiEs = {
  'testi0Date': 'Octubre 2025',
  'testi0P0':
      'Recomiendo a Tomás como un ingeniero sobresaliente. Tuve el privilegio de trabajar con él en IT-TechGroup y luego liderarlo como Team Lead en SportsVisio, vi su evolución de junior prometedor a ingeniero de primer nivel.',
  'testi0P1':
      'Lo que distingue a Tomás es su confiabilidad constante al entregar soluciones de alta calidad. Su trabajo en optimización de subidas TUS en segundo plano y la reescritura con Bloc en SportsVisio muestran su capacidad para abordar desafíos complejos y de alto impacto.',
  'testi0P2':
      'Tomás disfruta los problemas difíciles que intimidan a muchos. Podía irme de vacaciones sabiendo que él cubriría cualquier incidente crítico. Cualquier organización se beneficiaría de tenerlo en sus proyectos más exigentes.',
  'testi1Date': 'Enero 2025',
  'testi1P0':
      'Recomiendo encarecidamente a Tomás Sasovsky como desarrollador Flutter excepcional. En los últimos tres años trabajé con él como compañero y como su líder de equipo; sus aportes fueron invaluables.',
  'testi1P1':
      'Tomás aporta experiencia profunda en Flutter y desarrollo mobile, entregando siempre aplicaciones de alta calidad. Su capacidad de resolver problemas y escribir código limpio y escalable impulsó el éxito de numerosos proyectos.',
  'testi1P2':
      'Lo que lo distingue es su espíritu colaborativo: comparte conocimiento, orienta a quienes empiezan y construye un ambiente de trabajo positivo.',
  'testi2Date': 'Enero 2025',
  'testi2P0':
      'Trabajé estrechamente con Tomás durante 2,5 años en varios proyectos, incluido un app Android nativa compleja con un modelo de machine learning vía NDK.',
  'testi2P1':
      'Demostró excelencia técnica, en especial como desarrollador Flutter mobile, elevando nuestras capacidades en todo el stack mobile.',
  'testi2P2':
      'Un logro destacado fue diseñar e implementar un pipeline CI/CD robusto que simplificó nuestro desarrollo. Lo recomiendo a equipos que busquen un desarrollador mobile talentoso y con visión de futuro.',
  'testi3Date': 'Noviembre 2021',
  'testi3P0':
      'Desarrollador joven proactivo y resolutivo. Si no sabe algo lo investiga y entrega resultados, siempre. Se preocupa por la calidad del código y te lo garantiza.',
  'testi4Date': 'Noviembre 2021',
  'testi4P0':
      'Tomás es un joven muy talentoso, con sólidos conocimientos en Flutter. Muy comprometido con sus responsabilidades. Lo recomiendo como compañero o líder de proyecto: siempre dispuesto a aprender más y a ayudar de forma desinteresada.',
};

const _expEn = {
  'exp0Title': 'Full-Stack Developer — El Dorado P2P',
  'exp0Range': 'Feb 2025 — Sep 2025 · Buenos Aires (Hybrid)',
  'exp0Desc':
      'Built a public-facing TypeScript API for crypto-to-fiat exchanges across LATAM. Implemented U.S. bank account opening/linking to crypto wallets. Modularized the Flutter app for scalability and testability.',
  'exp1Title': 'Senior Flutter Engineer — SportsVisio',
  'exp1Range': 'Jan 2022 — Feb 2025 · Remote (US)',
  'exp1Desc':
      'Shipped SV Manager with background TUS uploads (−30% upload time). Delivered dual-view synchronized playback for 1200+ monthly users. Led Bloc-based rewrite (−35% code size). Built Android tracking with Kalman/Hungarian algorithms for single-angle recording.',
  'exp2Title': 'Team Lead, Senior Flutter Engineer — VisionBox',
  'exp2Range': 'Jan 2024 — Jun 2024 · Remote (Canada)',
  'exp2Desc':
      'Led a team of four; integrated Health Connect/HealthKit for AI insights. Implemented KYC with Google ML Kit; Face verification pipeline; Subscriptions via RevenueCat.',
  'exp3Title': 'Software Engineer (Freelance) — CourtAvenue',
  'exp3Range': 'Jul 2023 — Sep 2023 · Remote (US)',
  'exp3Desc':
      'Built Genjo (ChatGPT web wrapper) with Express/React; delivered ApiConnect in Flutter; internal tooling for multi-package repos; AI-driven passport/visa reader.',
  'exp4Title': 'Flutter Engineer — Creative Advanced Technologies',
  'exp4Range': 'Sep 2021 — Mar 2022 · Remote (UAE)',
  'exp4Desc':
      'Launched food ordering and delivery tracking apps (50K+ downloads, 4.5★). Google Maps integration and backend coordination.',
  'exp5Title': 'Flutter Engineer — It-TechGroup',
  'exp5Range': 'Jan 2021 — Nov 2021 · Remote (AR)',
  'exp5Desc':
      'Built a Flutter plugin to integrate MercadoPago Checkout SDK for Android/iOS (Java/Swift). Set up CI/CD for automated builds and tests.',
};

const _expEs = {
  'exp0Title': 'Full-Stack Developer — El Dorado P2P',
  'exp0Range': 'Feb 2025 — Sep 2025 · Buenos Aires (Hybrid)',
  'exp0Desc':
      'Construí una API TypeScript orientada al público para intercambios crypto-fiat en LATAM. Implementé apertura/vinculación de cuentas bancarias en EE.UU. a billeteras crypto. Modularicé la app Flutter para escalabilidad y testabilidad.',
  'exp1Title': 'Senior Flutter Engineer — SportsVisio',
  'exp1Range': 'Jan 2022 — Feb 2025 · Remote (US)',
  'exp1Desc':
      'Lancé SV Manager con subidas TUS en segundo plano (−30% tiempo de subida). Playback dual sincronizado para 1200+ usuarios mensuales. Lideré reescritura con Bloc (−35% código). Tracking Android con Kalman/Hungarian para grabación de un ángulo.',
  'exp2Title': 'Team Lead, Senior Flutter Engineer — VisionBox',
  'exp2Range': 'Jan 2024 — Jun 2024 · Remote (Canada)',
  'exp2Desc':
      'Lideré un equipo de cuatro; integré Health Connect/HealthKit para insights con IA. KYC con Google ML Kit; verificación facial; suscripciones con RevenueCat.',
  'exp3Title': 'Software Engineer (Freelance) — CourtAvenue',
  'exp3Range': 'Jul 2023 — Sep 2023 · Remote (US)',
  'exp3Desc':
      'Construí Genjo (wrapper web de ChatGPT) con Express/React; entregué ApiConnect en Flutter; tooling interno para monorepos; lector de pasaportes/visas con IA.',
  'exp4Title': 'Flutter Engineer — Creative Advanced Technologies',
  'exp4Range': 'Sep 2021 — Mar 2022 · Remote (UAE)',
  'exp4Desc':
      'Lancé apps de pedidos de comida y seguimiento de envíos (50K+ descargas, 4.5★). Integración con Google Maps y coordinación backend.',
  'exp5Title': 'Flutter Engineer — It-TechGroup',
  'exp5Range': 'Jan 2021 — Nov 2021 · Remote (AR)',
  'exp5Desc':
      'Construí un plugin Flutter para integrar el SDK MercadoPago Checkout en Android/iOS (Java/Swift). Configuré CI/CD para builds y tests automáticos.',
};
