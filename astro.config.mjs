// @ts-check
import { defineConfig } from 'astro/config';
import node from '@astrojs/node';

// https://astro.build/config
export default defineConfig({
  site: 'https://aquiles.dev',
  output: 'server', // Required for API routes to work in production
  adapter: node({
    mode: 'standalone',
  }),
});
