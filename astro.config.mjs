// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://aquiles.dev',
  // API routes require server-side rendering
  // Use 'server' for full SSR or 'hybrid' for static pages + API routes
  // For development, API routes work in dev mode regardless of output setting
  output: 'server', // Required for API routes to work in production
});
