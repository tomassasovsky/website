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
  // API endpoint path - this is safe to expose in frontend (just a URL path)
  // The actual email sending happens server-side in src/pages/api/contact.ts
  endpoint: "/api/contact",
  cooldownSeconds: 30,
  // Fallback email should be stored in environment variable, not hardcoded
  // Use: import.meta.env.CONTACT_EMAIL in API endpoints only (server-side)
  fallbackEmail: "", // Removed for security - use environment variable instead
};

