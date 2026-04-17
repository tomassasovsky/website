import '../models/models.dart';

const projects = <Project>[
  Project(
    title: 'El Dorado P2P',
    description:
        'A Stablecoin SuperApp for LATAM offering a USD wallet and a peer-to-peer marketplace '
        'across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). '
        'Built for reliability and ease of use to move value across borders, protect savings '
        'in USD, and enable P2P merchant workflows.',
    image: '/assets/images/eldorado-preview.jpg',
    tech: ['Flutter', 'Dart', 'Node.js', 'Bun'],
    links: [
      ProjectLink(label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=io.eldorado.app'),
      ProjectLink(label: 'App Store', href: 'https://apps.apple.com/co/app/el-dorado-p2p/id1591303547'),
    ],
    categories: ['Apps'],
  ),
  Project(
    title: 'SportsVisio App',
    description:
        'SportsVisio delivers player stats, analysis, and highlights in a secure, '
        'simple-to-use app to elevate your game with game-changing AI technology.',
    image: '/assets/images/sportsvisio-preview.png',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=com.sportsvisio.svhoops'),
      ProjectLink(label: 'App Store', href: 'https://apps.apple.com/us/app/sportsvisio/id1611231433'),
    ],
    categories: ['Apps'],
  ),
  Project(
    title: 'SportsVisio Manager',
    description:
        'Publish schedules and upload game video. SportsVisio converts footage into '
        'player stats and highlights for easy review in the SportsVisio app.',
    image: '/assets/images/sportsvisio-preview.png',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=com.sportsvisio.svrecord'),
    ],
    categories: ['Apps'],
  ),
  Project(
    title: 'SportsVisio Track',
    description:
        'Experimental native Android app for single-phone player/ball tracking. '
        'YOLO + MOT (Kalman + Hungarian), homography for court mapping. '
        'Kotlin (CameraX/MediaCodec), real-time and low power.',
    tech: ['Android', 'Kotlin', 'YOLO'],
    categories: ['Apps'],
    unreleased: true,
  ),
  Project(
    title: 'APIConnect',
    description:
        'Consumer app for API Abroad built with a modern stack and production-ready CI/CD. '
        'Emphasis on secure auth, dependable releases, and crisp UX to guide users '
        'through program discovery and onboarding.',
    image: '/assets/images/api-connect-preview.png',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(
        label: 'Google Play',
        href: 'https://play.google.com/store/apps/details?id=com.apiabroad.api_abroad_app',
      ),
      ProjectLink(label: 'App Store', href: 'https://apps.apple.com/es/app/apiconnect/id6448320549'),
    ],
    categories: ['Apps'],
  ),
  Project(
    title: 'TAZA Express',
    description:
        'Food ordering and delivery tracking for a high-volume marketplace. '
        'Implemented map integrations and streamlined order states for a '
        'predictable end-to-end experience.',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(
        label: 'Google Play',
        href: 'https://play.google.com/store/apps/details?id=com.creativeadvtech.taza_mobile_production',
      ),
      ProjectLink(label: 'App Store', href: 'https://apps.apple.com/ar/app/taza-express/id1614409775'),
    ],
    categories: ['Apps'],
  ),
  Project(
    title: 'Genjo',
    description:
        'AI-powered platform designed to transform browsers into buyers, enhance customer '
        'interactions, and generate leads. Offers personalised, 24/7 customer engagement, '
        'boosting conversions and average order values while reducing returns.',
    tech: ['React Native', 'TypeScript', 'Expo'],
    links: [
      ProjectLink(label: 'Website', href: 'https://genjo.ai/'),
    ],
    categories: ['Apps'],
  ),
  Project(
    title: 'Genomii',
    description:
        'Health insights and guidance with device integrations and privacy-first design. '
        'Responsibilities covered integrations, subscriptions, and KYC/verification flows.',
    image: '/assets/images/genomii-preview.png',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(label: 'Website', href: 'https://genomii.ai/'),
    ],
    categories: ['Apps'],
    unreleased: true,
  ),
  Project(
    title: 'Go Router Guards',
    description:
        'Flexible and extensible guard system for Go Router with composable boolean logic '
        'and type-safe routes. Supports ALL/ANY/ONE-OF combinations, redirect semantics, '
        'and a GuardedRoute mixin. Includes examples and tests for robust, reusable route protection.',
    image: '/assets/images/go-router-guards-logo.png',
    imageFit: 'contain',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(label: 'Documentation', href: 'https://guards.aquiles.dev/'),
      ProjectLink(label: 'GitHub', href: 'https://github.com/tomassasovsky/go_router_guards'),
    ],
    categories: ['OSS / Tools'],
  ),
  Project(
    title: 'Radio Horizon (Dart)',
    description:
        'Discord radio playing bot with powerful song recognition technology. '
        'Identifies and announces songs currently playing on the radio, '
        'making it easy to keep track of your favourite tunes.',
    image: '/assets/images/radio-horizon-logo.png',
    tech: ['Dart'],
    links: [
      ProjectLink(label: 'GitHub', href: 'https://github.com/tomassasovsky/radio-horizon.dart'),
      ProjectLink(label: 'Discord', href: 'https://discord.com/discovery/applications/977793621896093736'),
    ],
    categories: ['OSS / Tools'],
  ),
  Project(
    title: 'ncnn.dart',
    description:
        'Dart FFI bindings and tooling around Tencent NCNN for on-device neural inference. '
        'Targets mobile and desktop with zero-copy buffers where possible and pragmatic '
        'model loading. Useful for small, fast CNNs without heavyweight runtimes.',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(label: 'GitHub', href: 'https://github.com/tomassasovsky/ncnn.dart'),
    ],
    categories: ['OSS / Tools'],
  ),
  Project(
    title: 'pytorch.dart',
    description:
        'Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and '
        'model execution. Explores FFI surfaces for tensors, autograd, and model invocation '
        'from Flutter. Aimed at research/prototyping.',
    tech: ['Flutter', 'Dart'],
    links: [
      ProjectLink(label: 'GitHub', href: 'https://github.com/tomassasovsky/pytorch.dart'),
    ],
    categories: ['OSS / Tools'],
  ),
  Project(
    title: 'automatic_version_upgrader.dart',
    description:
        'CLI helper to automatically bump Dart/Flutter package versions and changelogs. '
        'Parses conventional commits, updates pubspec, and generates changelog entries '
        'with semantic versioning. Designed to fit CI pipelines.',
    tech: ['Dart'],
    links: [
      ProjectLink(label: 'GitHub', href: 'https://github.com/tomassasovsky/automatic_version_upgrader.dart'),
    ],
    categories: ['OSS / Tools'],
  ),
  Project(
    title: 'tus_client',
    description:
        'Dart client for the TUS resumable upload protocol with reliable, restartable uploads. '
        'Handles chunking, retries, and metadata, with pluggable storage for resumption '
        'across app restarts. Great for large files and flaky networks.',
    tech: ['Dart'],
    links: [
      ProjectLink(label: 'GitHub', href: 'https://github.com/tomassasovsky/tus_client'),
    ],
    categories: ['OSS / Tools'],
  ),
];
