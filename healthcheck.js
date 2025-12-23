#!/usr/bin/env node
// Simple healthcheck script for Docker
const http = require('http');

const port = process.env.PORT || 4321;
const options = {
  hostname: 'localhost',
  port: port,
  path: '/',
  method: 'GET',
  timeout: 5000
};

const req = http.request(options, (res) => {
  if (res.statusCode === 200) {
    process.exit(0);
  } else {
    process.exit(1);
  }
});

req.on('error', () => {
  process.exit(1);
});

req.on('timeout', () => {
  req.destroy();
  process.exit(1);
});

req.end();

