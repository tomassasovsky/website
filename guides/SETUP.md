# Contact Form Setup Guide

Complete setup guide for the contact form using Gmail API with OAuth2 authentication.

## Quick Setup

### 1. Create Google Cloud Project & OAuth2 Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing)
3. Enable Gmail API:
   - Go to "APIs & Services" → "Library"
   - Search "Gmail API" → Enable
4. Create OAuth2 credentials:
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "OAuth client ID"
   - Configure OAuth consent screen (if first time):
     - Choose "External"
     - App name: "Portfolio Contact Form"
     - User support email: your email
     - Add scope: `https://www.googleapis.com/auth/gmail.send`
   - Create OAuth client:
     - **Type: "Web application"** (NOT "Desktop app" - OOB flow is deprecated)
     - Name: "Portfolio Contact Form"
     - **Authorized redirect URI**: `http://localhost:3000/callback`
   - Copy **Client ID** and **Client Secret**

### 2. Get Refresh Token

1. Add credentials to `.env`:
   ```bash
   GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
   GOOGLE_CLIENT_SECRET=your-client-secret
   ```

2. Run the helper script:
   ```bash
   node get-refresh-token.js
   ```

3. Follow the prompts:
   - Visit the URL shown in terminal
   - Sign in and authorize
   - Copy the refresh token displayed

### 3. Configure Environment Variables

Create `.env` file in project root:

```bash
# Email to receive form submissions
CONTACT_EMAIL=your-email@example.com

# OAuth2 Credentials (from Google Cloud Console)
GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=your-client-secret

# Refresh Token (from get-refresh-token.js script)
GOOGLE_REFRESH_TOKEN=your-refresh-token-here

# Your Gmail/Google Workspace email
GOOGLE_USER_EMAIL=your-email@gmail.com
```

### 4. Start Server

```bash
npm run dev
```

### 5. Test

Submit the contact form and check your email inbox.

## How It Works

- Form submits to `/api/contact` endpoint (server-side only)
- Endpoint validates and sanitizes input
- OAuth2 access token refreshes automatically
- Email sent via Gmail API (not SMTP)
- No passwords stored - only secure OAuth2 tokens

## Production Deployment

Set environment variables in your hosting platform:
- **Vercel**: Project Settings → Environment Variables
- **Netlify**: Site Settings → Environment Variables
- **Railway/Render**: Environment tab

## Security Features

✅ OAuth2 authentication (no passwords)  
✅ Input validation and sanitization  
✅ XSS protection  
✅ Honeypot spam protection  
✅ Auto-refreshing access tokens  
✅ Revocable access (revoke in Google Cloud Console)

## Troubleshooting

See `TROUBLESHOOTING.md` for common issues and solutions.

