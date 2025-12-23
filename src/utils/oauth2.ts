/**
 * OAuth2 helper for Gmail API authentication
 * Uses Google OAuth2 to get access tokens for sending emails via Gmail API
 */

import { google } from "googleapis";

/**
 * Get OAuth2 access token for Gmail API
 * Automatically refreshes the token if expired
 */
export async function getAccessToken(): Promise<string> {
  // Read from process.env directly for SSR/runtime environment variables
  const clientId = import.meta.env.GOOGLE_CLIENT_ID || process.env.GOOGLE_CLIENT_ID;
  const clientSecret = import.meta.env.GOOGLE_CLIENT_SECRET || process.env.GOOGLE_CLIENT_SECRET;
  const refreshToken = import.meta.env.GOOGLE_REFRESH_TOKEN || process.env.GOOGLE_REFRESH_TOKEN;

  if (!clientId || !clientSecret || !refreshToken) {
    throw new Error(
      "OAuth2 credentials not configured. Required: GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, GOOGLE_REFRESH_TOKEN",
    );
  }

  // Use configurable redirect URI from environment, fallback to localhost for development
  const redirectUri =
    import.meta.env.GOOGLE_REDIRECT_URI || process.env.GOOGLE_REDIRECT_URI ||
    (import.meta.env.PUBLIC_SITE_URL || process.env.PUBLIC_SITE_URL) + "/callback" ||
    "http://localhost:3000/callback";

  const oauth2Client = new google.auth.OAuth2(
    clientId,
    clientSecret,
    redirectUri, // Redirect URI (must match Google Cloud Console)
  );

  oauth2Client.setCredentials({
    refresh_token: refreshToken,
  });

  // Get access token (will auto-refresh if expired)
  const { credentials } = await oauth2Client.refreshAccessToken();

  if (!credentials.access_token) {
    throw new Error("Failed to obtain access token");
  }

  return credentials.access_token;
}

