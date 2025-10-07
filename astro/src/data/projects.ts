import type { Project } from "../types";

export const projects: Project[] = [
  {
    title: "El Dorado P2P",
    description: "A Stablecoin SuperApp for LATAM offering a USD wallet and a peer‑to‑peer marketplace across 70+ finance apps (PayPal, Zelle, PIX, MercadoPago, Nequi, and more). Built for reliability and ease of use to move value across borders, protect savings in USD, and enable P2P merchant workflows.",
    image: "/assets/images/eldorado-preview.jpg",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=io.eldorado.app" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/co/app/el-dorado-p2p/id1591303547" },
    ],
    category: "web development",
  },
  {
    title: "SportsVisio",
    description: "End‑to‑end mobile capture and upload pipeline with background transfers, synchronized dual‑view playback, and analytics features tailored for teams and leagues. Focused on reliable uploads, smooth playback, and scalable media workflows.",
    image: "/assets/images/sportsvisio-preview.png",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.sportsvisio.svhoops" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/us/app/sportsvisio/id1611231433" },
    ],
    category: "applications",
  },
  {
    title: "APIConnect (CourtAvenue)",
    description: "Consumer app for API Abroad built with a modern stack and production‑ready CI/CD. Emphasis on secure auth, dependable releases, and crisp UX to guide users through program discovery and onboarding.",
    image: "/assets/images/api-connect-preview.png",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.apiabroad.api_abroad_app" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/es/app/apiconnect/id6448320549" },
    ],
    category: "applications",
  },
  {
    title: "TAZA Express",
    description: "Food ordering and delivery tracking for a high‑volume marketplace. Implemented map integrations and streamlined order states for a predictable end‑to‑end experience.",
    image: "/assets/images/cat-logo.webp",
    links: [
      { label: "Google Play", icon: "logo-google-playstore", href: "https://play.google.com/store/apps/details?id=com.creativeadvtech.taza_mobile_production" },
      { label: "App Store", icon: "logo-apple", href: "https://apps.apple.com/ar/app/taza-express/id1614409775" },
    ],
    category: "applications",
  },
  {
    title: "Genjo (CourtAvenue)",
    description: "Lightweight web app used internally to streamline LLM‑assisted workflows and knowledge retrieval. Built to move fast: pragmatic stack, clear UX, and rapid iteration.",
    image: "/assets/images/courtavenue-logo.png",
    links: [
      { label: "Website", icon: "globe-outline", href: "https://genjo.ai/" },
    ],
    category: "web development",
  },
  {
    title: "Genomii (VisionBox)",
    description: "Health insights and guidance with device integrations and privacy‑first design. Unreleased; responsibilities covered integrations, subscriptions, and KYC/verification flows.",
    image: "/assets/images/visionbox-ai-logo.png",
    links: [
      { label: "Website", icon: "globe-outline", href: "https://genomii.ai/" },
    ],
    category: "web design",
  },
];

