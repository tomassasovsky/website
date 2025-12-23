/**
 * One-time script to get OAuth2 refresh token for Gmail SMTP
 * Uses localhost redirect URI (OOB flow is deprecated by Google)
 * 
 * Usage:
 * 1. Set GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET in .env
 * 2. Make sure redirect URI is set to http://localhost:3000/callback in Google Cloud Console
 * 3. Run: node get-refresh-token.js
 * 4. Visit the URL shown and authorize - the script will automatically capture the code
 */

import { google } from 'googleapis';
import http from 'http';
import { config } from 'dotenv';
import { URL } from 'url';

// Load environment variables
config();

const SCOPES = ['https://www.googleapis.com/auth/gmail.send'];
const REDIRECT_URI = 'http://localhost:3000/callback';
const PORT = 3000;

async function getRefreshToken() {
  const clientId = process.env.GOOGLE_CLIENT_ID;
  const clientSecret = process.env.GOOGLE_CLIENT_SECRET;

  if (!clientId || !clientSecret) {
    console.error('❌ Error: GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET must be set in .env file');
    console.log('\nExample .env:');
    console.log('GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com');
    console.log('GOOGLE_CLIENT_SECRET=your-client-secret');
    process.exit(1);
  }

  const oauth2Client = new google.auth.OAuth2(
    clientId,
    clientSecret,
    REDIRECT_URI
  );

  const authUrl = oauth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
    prompt: 'consent', // Force consent screen to get refresh token
  });

  console.log('\n📧 Gmail OAuth2 Setup\n');
  console.log('Starting local server to capture authorization code...\n');
  console.log('1. Visit this URL in your browser:');
  console.log('\n' + authUrl + '\n');
  console.log('2. Sign in with your Google account');
  console.log('3. Click "Allow" to grant Gmail send permissions');
  console.log('4. You will be redirected back automatically\n');

  // Create HTTP server to catch the redirect
  const server = http.createServer(async (req, res) => {
    try {
      const url = new URL(req.url || '/', `http://localhost:${PORT}`);
      const code = url.searchParams.get('code');
      const error = url.searchParams.get('error');

      if (error) {
        res.writeHead(400, { 'Content-Type': 'text/html' });
        res.end(`
          <html>
            <body>
              <h1>Authorization Failed</h1>
              <p>Error: ${error}</p>
              <p>You can close this window.</p>
            </body>
          </html>
        `);
        server.close();
        console.error('\n❌ Authorization failed:', error);
        process.exit(1);
        return;
      }

      if (!code) {
        res.writeHead(400, { 'Content-Type': 'text/html' });
        res.end(`
          <html>
            <body>
              <h1>No authorization code received</h1>
              <p>You can close this window and try again.</p>
            </body>
          </html>
        `);
        return;
      }

      // Exchange code for tokens
      try {
        const { tokens } = await oauth2Client.getToken(code);
        
        if (!tokens.refresh_token) {
          res.writeHead(400, { 'Content-Type': 'text/html' });
          res.end(`
            <html>
              <body>
                <h1>No Refresh Token</h1>
                <p>This can happen if you've already authorized the app before.</p>
                <p>Try revoking access first, then run this script again.</p>
                <p>You can close this window.</p>
              </body>
            </html>
          `);
          server.close();
          console.error('\n❌ Error: No refresh token received.');
          console.log('This can happen if you\'ve already authorized the app before.');
          console.log('Try revoking access first, then run this script again.');
          process.exit(1);
          return;
        }

        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`
          <html>
            <body>
              <h1>✅ Success!</h1>
              <p>Authorization complete. You can close this window.</p>
              <p>Check your terminal for the refresh token.</p>
            </body>
          </html>
        `);

        server.close();

        console.log('\n✅ Success! OAuth2 tokens obtained.\n');
        console.log('Add this to your .env file:\n');
        console.log(`GOOGLE_REFRESH_TOKEN=${tokens.refresh_token}`);
        console.log(`GOOGLE_USER_EMAIL=your-email@example.com\n`);
        console.log('Then restart your dev server: npm run dev\n');
        process.exit(0);
      } catch (tokenError) {
        res.writeHead(400, { 'Content-Type': 'text/html' });
        res.end(`
          <html>
            <body>
              <h1>Token Exchange Failed</h1>
              <p>Error: ${tokenError.message}</p>
              <p>You can close this window.</p>
            </body>
          </html>
        `);
        server.close();
        console.error('\n❌ Error retrieving tokens:', tokenError.message);
        process.exit(1);
      }
    } catch (err) {
      res.writeHead(500, { 'Content-Type': 'text/html' });
      res.end('<html><body><h1>Server Error</h1></body></html>');
      server.close();
      console.error('Server error:', err);
      process.exit(1);
    }
  });

  server.listen(PORT, () => {
    console.log(`Local server running on http://localhost:${PORT}`);
    console.log('Waiting for authorization...\n');
  });

  // Handle server errors
  server.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
      console.error(`\n❌ Port ${PORT} is already in use.`);
      console.log('Please close any application using port 3000 and try again.');
      process.exit(1);
    } else {
      console.error('Server error:', err);
      process.exit(1);
    }
  });
}

getRefreshToken();

