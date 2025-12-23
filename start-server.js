#!/usr/bin/env node
// Startup script for Astro Node adapter in Docker
// The adapter should auto-start, but we ensure HOST and PORT are set
process.env.HOST = process.env.HOST || '0.0.0.0';
process.env.PORT = process.env.PORT || '4321';

console.log(`Starting Astro server on ${process.env.HOST}:${process.env.PORT}`);

// Import the entry module - it should auto-start the server
import('./dist/server/entry.mjs').catch((error) => {
  console.error('Failed to start server:', error);
  process.exit(1);
});

