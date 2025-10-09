import type { Project } from "../types";

export const projects: Project[] = [
  {
    title: "El Dorado P2P",
    description: "A Stablecoin SuperApp for LATAM offering a USD wallet and a peer‑to‑peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.",
    image: "/assets/images/eldorado-preview.jpg",
    imageFit: "cover",
    tech: ["Flutter", "Dart", "node.js", "bun"],
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=io.eldorado.app" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/co/app/el-dorado-p2p/id1591303547" },
    ],
    categories: ["Apps"],
  },
  {
    title: "SportsVisio App",
    description: "SportsVisio delivers player stats, analysis, and highlights in a secure, simple-to-use app to elevate your game with game-changing AI technology.",
    image: "/assets/images/sportsvisio-preview.png",
    imageFit: "cover",
    tech: ["Flutter", "Dart"],
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.sportsvisio.svhoops" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/us/app/sportsvisio/id1611231433" },
    ],
    categories: ["Apps"],
  },
  {
    title: "SportsVisio Manager",
    description: "Publish schedules and upload game video. SportsVisio converts footage into player stats and highlights for easy review in the SportsVisio app.",
    image: "/assets/images/sportsvisio-preview.png",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.sportsvisio.svrecord" },
    ],
    imageFit: "cover",
    tech: ["Flutter", "Dart"],
    categories: ["Apps"],
  },
  {
    title: "SportsVisio Track (Experimental, Native Android)",
    unreleased: true,
    description: "Experimental native Android app for single‑phone player/ball tracking. YOLO + MOT (Kalman + Hungarian), homography for court mapping. Kotlin (CameraX/MediaCodec), real‑time and low power.",
    imageFit: "cover",
    tech: ["Android", "Kotlin", "YOLO", "Kalman", "Hungarian", "CameraX", "MediaCodec"],
    categories: ["Apps"],
  },
  {
    title: "APIConnect (CourtAvenue)",
    description: "Consumer app for API Abroad built with a modern stack and production‑ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.",
    image: "/assets/images/api-connect-preview.png",
    imageFit: "cover",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.apiabroad.api_abroad_app" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/es/app/apiconnect/id6448320549" },
    ],
    tech: ["Flutter", "Dart"],
    categories: ["Apps"],
  },
  {
    title: "TAZA Express",
    description: "Food ordering and delivery tracking for a high‑volume marketplace. Implemented map integrations and streamlined order states for a predictable end‑to‑end experience.",
    imageFit: "cover",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.creativeadvtech.taza_mobile_production" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/ar/app/taza-express/id1614409775" },
    ],
    tech: ["Flutter", "Dart"],
    categories: ["Apps"],
  },
  {
    title: "Genjo (CourtAvenue)",
    description: "Genjo is an AI-powered platform designed to transform browsers into buyers, enhance customer interactions, and generate leads. It offers personalized, 24/7 customer engagement, boosting conversions and average order values while reducing returns. Genjo serves industries like Automotive, SaaS, Ecommerce, and more, providing secure and private solutions tailored to your business needs.",
    imageFit: "contain",
    links: [
      { label: "Website", icon: "globe-outline", href: "https://genjo.ai/" },
    ],
    tech: ["React Native", "TypeScript", "Expo"],
    categories: ["Apps"],
  },
  {
    title: "Genomii (VisionBox)",
    unreleased: true,
    description: "Health insights and guidance with device integrations and privacy‑first design. Unreleased; responsibilities covered integrations, subscriptions, and KYC/verification flows.",
    imageFit: "cover",
    image: "/assets/images/genomii-preview.png",
    links: [
      { label: "Website", icon: "globe-outline", href: "https://genomii.ai/" },
    ],
    tech: ["Flutter", "Dart"],
    categories: ["Apps"],
  },
  {
    title: "Go Router Guards",
    description:
      "Flexible and extensible guard system for Go Router with composable boolean logic and type‑safe routes. Supports ALL/ANY/ONE‑OF combinations, redirect semantics, and a GuardedRoute mixin for type‑safe navigation. Includes examples and tests for building robust, reusable route protection.",
    image: "/assets/images/go-router-guards-logo.png",
    imageFit: "contain",
    links: [
      {
        label: "Documentation",
        icon: "globe-outline",
        href: "https://guards.aquiles.dev/",
      },
      {
        label: "GitHub",
        icon: "globe-outline",
        href: "https://github.com/tomassasovsky/go_router_guards",
      }
    ],
    categories: ["OSS / Tools"],
    tech: ["Flutter", "Dart"],
  },
  {
    title: "Radio Horizon (Dart)",
    description:
      "Radio Horizon is a Discord radio playing bot that brings a whole new level of listening experience to your server. With its powerful song recognition technology, radio-horizon.dart can identify and announce the songs currently playing on the radio, making it easy to keep track of your favorite tunes. Whether you're a music lover, DJ or just looking for an easy way to discover new music, radio-horizon.dart is the perfect companion.",
    image: "/assets/images/radio-horizon-logo.png",
    imageFit: "cover",
    links: [
      {
        label: "GitHub",
        icon: "globe-outline",
        href: "https://github.com/tomassasovsky/radio-horizon.dart",
      },
      {
        label: "Discord",
        icon: "logo-discord",
        href: "https://discord.com/discovery/applications/977793621896093736",
      }
    ],
    categories: ["OSS / Tools"],
    tech: ["Dart"],
  },
  {
    title: "ncnn.dart",
    description:
      "Dart FFI bindings and tooling around Tencent NCNN for on‑device neural inference. Targets mobile and desktop with zero‑copy buffers where possible and pragmatic model loading. Useful for small, fast CNNs without heavyweight runtimes.",
    imageFit: "contain",
    links: [
      {
        label: "GitHub",
        icon: "globe-outline",
        href: "https://github.com/tomassasovsky/ncnn.dart",
      },
    ],
    categories: ["OSS / Tools"],
    tech: ["Flutter", "Dart"],
  },
  {
    title: "pytorch.dart",
    description:
      "Experimental Dart bindings for LibTorch/PyTorch to enable native tensor ops and model execution. Explores FFI surfaces for tensors, autograd, and model invocation from Flutter. Aimed at research/prototyping rather than production stability.",
    imageFit: "contain",
    links: [
      {
        label: "GitHub",
        icon: "globe-outline",
        href: "https://github.com/tomassasovsky/pytorch.dart",
      },
    ],
    categories: ["OSS / Tools"],
    tech: ["Flutter", "Dart"],
  },
  {
    title: "automatic_version_upgrader.dart",
    description:
      "CLI helper to automatically bump Dart/Flutter package versions and changelogs. Parses conventional commits, updates pubspec, and generates changelog entries with semantic versioning. Designed to fit CI pipelines for consistent releases.",
    imageFit: "contain",
    links: [
      {
        label: "GitHub",
        icon: "globe-outline",
        href: "https://github.com/tomassasovsky/automatic_version_upgrader.dart",
      },
    ],
    categories: ["OSS / Tools"],
    tech: ["Dart"],
  },
  {
    title: "tus_client",
    description:
      "Dart client for the TUS resumable upload protocol with reliable, restartable uploads. Handles chunking, retries, and metadata, with pluggable storage for resumption across app restarts. Great for large files and flaky networks.",
    imageFit: "contain",
    links: [
      {
        label: "GitHub",
        icon: "globe-outline",
        href: "https://github.com/tomassasovsky/tus_client",
      },
    ],
    categories: ["OSS / Tools"],
    tech: ["Dart"],
  },
];

