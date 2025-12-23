#!/usr/bin/env node
// Simple healthcheck script for Docker
import http from 'http';

const port = process.env.PORT || 4321;
const options = {
  hostname: 'localhost',
  port: port,
  path: '/api/health',
  method: 'GET',
  timeout: 5000
};

const req = http.request(options, (res) => {
  // Consume the response to free up resources
  res.on('data', () => {});
  res.on('end', () => {
    // Accept 200-399 status codes as healthy
    if (res.statusCode >= 200 && res.statusCode < 400) {
      process.exit(0);
    } else {
      console.error(`Health check failed: Status code ${res.statusCode}`);
      process.exit(1);
    }
  });
});

req.on('error', (err) => {
  console.error('Health check error:', err.message);
  process.exit(1);
});

req.on('timeout', () => {
  req.destroy();
  console.error('Health check timeout');
  process.exit(1);
});

req.end();

