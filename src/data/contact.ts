import type { Booking, ContactSettings } from "../types";

export const booking: Booking = {
  ctaTitle: "Book a meeting",
  description: [
    "Pick a time that works for you using my calendar.",
    "You’ll get a confirmation and a video meeting link automatically.",
  ],
  url: "https://calendar.app.google/km4dUWyzkW97TRhG9",
};

export const contact: ContactSettings = {
  endpoint: "", // set to your API/endpoint to enable
  cooldownSeconds: 30,
  fallbackEmail: "tomas@aquiles.dev",
};

