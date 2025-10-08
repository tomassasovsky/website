import type { Client } from "../types";

export const clients: Client[] = [
  { name: "El Dorado P2P", logo: "/assets/images/eldorado-logo.png", url: "https://eldorado.io/" },
  { name: "SportsVisio", logoDark: "/assets/images/sportsvisio-logo-dark.svg", logoLight: "/assets/images/sportsvisio-logo-light.svg", url: "https://sportsvisio.com/" },
  {
    name: "CourtAvenue",
    url: "https://www.courtavenue.com/",
    logoDark: "/assets/images/courtavenue-logo-dark.png",
    logoLight: "/assets/images/courtavenue-logo-light.png",
    logoClass: "logo-badge",
  },
  { name: "VisionBox", logoDark: "/assets/images/visionbox-ai-logo-dark.png", logoLight: "/assets/images/visionbox-ai-logo-light.png", url: "https://www.visionbox.ca/" },
  { name: "Creative Advanced Technologies", logo: "/assets/images/cat-logo.webp", url: "https://www.creativeadvancedtech.com/" },
  { name: "It‑TechGroup", logoDark: "/assets/images/it-techgroup-dark.png", logoLight: "/assets/images/it-techgroup-light.png", url: "https://it-techgroup.com/" },
];

