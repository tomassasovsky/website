/// Non-translatable project metadata (URLs, tech stack, assets). Copy lives in ARB (`proj0Title`, …).
library;

import 'link_kind.dart';

/// Link targets for each portfolio project (order matches `proj0…proj13` in ARB).
final List<ProjectShell> projectShells = [
  (
    tech: ['Flutter', 'Dart', 'Node.js', 'Bun'],
  image: '/assets/images/eldorado-preview.jpeg',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: false,
    links: [
      (LinkKind.googlePlay, 'https://play.google.com/store/apps/details?id=io.eldorado.app'),
      (LinkKind.appStore, 'https://apps.apple.com/co/app/el-dorado-p2p/id1591303547'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/sportsvisio-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: false,
    links: [
      (LinkKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.sportsvisio.svhoops'),
      (LinkKind.appStore, 'https://apps.apple.com/us/app/sportsvisio/id1611231433'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/sportsvisio-manager-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: false,
    links: [
      (LinkKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.sportsvisio.svrecord'),
    ],
  ),
  (
    tech: ['Android', 'Kotlin', 'YOLO'],
    image: '/assets/images/sportsvisio-track-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: true,
    links: <(LinkKind, String)>[],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/apiconnect-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: false,
    links: [
      (LinkKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.apiabroad.api_abroad_app'),
      (LinkKind.appStore, 'https://apps.apple.com/es/app/apiconnect/id6448320549'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/taza-express-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: false,
    links: [
      (LinkKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.creativeadvtech.taza_mobile_production'),
      (LinkKind.appStore, 'https://apps.apple.com/ar/app/taza-express/id1614409775'),
    ],
  ),
  (
    tech: ['React Native', 'TypeScript', 'Expo'],
    image: '/assets/images/genjo-portfolio-cover.png',
    imageFit: 'fill',
    categories: ['apps'],
    unreleased: false,
    links: [
      (LinkKind.website, 'https://genjo.ai/'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/genomii-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['apps'],
    unreleased: true,
    links: [
      (LinkKind.website, 'https://genomii.ai/'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/guards-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['oss'],
    unreleased: false,
    links: [
      (LinkKind.documentation, 'https://guards.aquiles.dev/'),
      (LinkKind.github, 'https://github.com/tomassasovsky/go_router_guards'),
    ],
  ),
  (
    tech: ['Dart'],
    image: '/assets/images/radio-horizon-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['oss'],
    unreleased: false,
    links: [
      (LinkKind.github, 'https://github.com/tomassasovsky/radio-horizon.dart'),
      (LinkKind.discord, 'https://discord.com/discovery/applications/977793621896093736'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/ncnn-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['oss'],
    unreleased: false,
    links: [
      (LinkKind.github, 'https://github.com/tomassasovsky/ncnn.dart'),
    ],
  ),
  (
    tech: ['Flutter', 'Dart'],
    image: '/assets/images/pytorch-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['oss'],
    unreleased: false,
    links: [
      (LinkKind.github, 'https://github.com/tomassasovsky/pytorch.dart'),
    ],
  ),
  (
    tech: ['Dart'],
    image: '/assets/images/version-upgrader-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['oss'],
    unreleased: false,
    links: [
      (LinkKind.github, 'https://github.com/tomassasovsky/automatic_version_upgrader.dart'),
    ],
  ),
  (
    tech: ['Dart'],
    image: '/assets/images/tus-client-portfolio-cover.png',
    imageFit: 'cover',
    categories: ['oss'],
    unreleased: false,
    links: [
      (LinkKind.github, 'https://github.com/tomassasovsky/tus_client'),
    ],
  ),
];

typedef ProjectShell = ({
  List<String> tech,
  String? image,
  String imageFit,
  List<String> categories,
  bool unreleased,
  List<(LinkKind, String)> links,
});
