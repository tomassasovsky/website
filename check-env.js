#!/usr/bin/env node
// Quick script to check if environment variables are available
console.log('Environment Variables Check:');
console.log('CONTACT_EMAIL:', process.env.CONTACT_EMAIL ? 'SET' : 'NOT SET');
console.log('GOOGLE_CLIENT_ID:', process.env.GOOGLE_CLIENT_ID ? 'SET' : 'NOT SET');
console.log('GOOGLE_CLIENT_SECRET:', process.env.GOOGLE_CLIENT_SECRET ? 'SET' : 'NOT SET');
console.log('GOOGLE_REFRESH_TOKEN:', process.env.GOOGLE_REFRESH_TOKEN ? 'SET' : 'NOT SET');
console.log('GOOGLE_USER_EMAIL:', process.env.GOOGLE_USER_EMAIL ? 'SET' : 'NOT SET');
console.log('\nAll environment variables:');
const envKeys = Object.keys(process.env).sort();
envKeys.forEach(key => {
  if (key.includes('GOOGLE') || key.includes('CONTACT') || key.includes('PORT') || key.includes('HOST')) {
    console.log(`${key}: ${process.env[key] ? 'SET' : 'NOT SET'}`);
  }
});

