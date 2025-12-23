import type { APIRoute } from "astro";
import { getAccessToken } from "../../utils/oauth2";
import {
  checkRateLimit,
  getClientIP,
  sanitizeEmailHeader,
  isValidContentType,
  validateBodySize,
  validateInputLengths,
  getCORSHeaders,
} from "../../utils/security";
import { isValidEmail } from "../../utils/validation";

/**
 * Contact form API endpoint
 * 
 * This endpoint sends emails using Gmail API with OAuth2 authentication.
 * Uses googleapis library to send emails directly via Gmail API (not SMTP).
 * 
 * Required environment variables:
 * - CONTACT_EMAIL: Email address to receive form submissions
 * - GOOGLE_CLIENT_ID: OAuth2 client ID from Google Cloud Console
 * - GOOGLE_CLIENT_SECRET: OAuth2 client secret from Google Cloud Console
 * - GOOGLE_REFRESH_TOKEN: OAuth2 refresh token (obtained through OAuth flow)
 * - GOOGLE_USER_EMAIL: Your Gmail/Google Workspace email address
 * 
 * See SETUP.md for detailed setup instructions.
 */

export const POST: APIRoute = async ({ request, url }) => {
  const corsHeaders = getCORSHeaders();
  const defaultHeaders = {
    "Content-Type": "application/json",
    ...corsHeaders,
  };

  try {
    if (!isValidContentType(request)) {
      return new Response(
        JSON.stringify({ error: "Content-Type must be application/json" }),
        {
          status: 400,
          headers: defaultHeaders,
        },
      );
    }

    const bodyText = await request.text();

    // Validate body size (max 10KB)
    if (!validateBodySize(bodyText, 10000)) {
      return new Response(
        JSON.stringify({ error: "Request body too large" }),
        {
          status: 413,
          headers: defaultHeaders,
        },
      );
    }

    let data: any;
    try {
      data = JSON.parse(bodyText);
    } catch (e) {
      return new Response(
        JSON.stringify({ error: "Invalid JSON in request body" }),
        {
          status: 400,
          headers: defaultHeaders,
        },
      );
    }

    const { name, email, subject, message, website } = data;

    // Check honeypot field (spam protection)
    if (website && typeof website === "string" && website.trim().length > 0) {
      // Bot detected, silently return success to avoid revealing honeypot
      return new Response(
        JSON.stringify({
          success: true,
          message: "Message sent successfully",
        }),
        {
          status: 200,
          headers: defaultHeaders,
        },
      );
    }

    // Rate limiting
    const clientIP = getClientIP(request);
    const rateLimitResult = checkRateLimit(clientIP);
    if (!rateLimitResult.allowed) {
      return new Response(
        JSON.stringify({
          error: "Too many requests. Please try again later.",
        }),
        {
          status: 429,
          headers: {
            ...defaultHeaders,
            "Retry-After": Math.ceil(
              (rateLimitResult.resetTime - Date.now()) / 1000,
            ).toString(),
            "X-RateLimit-Limit": "5",
            "X-RateLimit-Remaining": "0",
            "X-RateLimit-Reset": new Date(rateLimitResult.resetTime).toISOString(),
          },
        },
      );
    }

    if (!name || !email || !subject || !message) {
      return new Response(
        JSON.stringify({ error: "All fields are required" }),
        {
          status: 400,
          headers: defaultHeaders,
        },
      );
    }

    const sanitizedData = {
      name: String(name).trim(),
      email: String(email).trim(),
      subject: String(subject).trim(),
      message: String(message).trim(),
    };

    const lengthValidation = validateInputLengths(sanitizedData);
    if (!lengthValidation.valid) {
      return new Response(
        JSON.stringify({ error: lengthValidation.errors[0] }),
        {
          status: 400,
          headers: defaultHeaders,
        },
      );
    }

    if (!isValidEmail(sanitizedData.email)) {
      return new Response(
        JSON.stringify({ error: "Invalid email address" }),
        {
          status: 400,
          headers: defaultHeaders,
        },
      );
    }

    const recipientEmail = import.meta.env.CONTACT_EMAIL;
    if (!recipientEmail) {
      console.error("CONTACT_EMAIL environment variable not set");
      return new Response(
        JSON.stringify({
          error: "Email service not configured. Please contact the site administrator.",
        }),
        {
          status: 500,
          headers: defaultHeaders,
        },
      );
    }

    const userEmail = import.meta.env.GOOGLE_USER_EMAIL;
    if (!userEmail) {
      console.error("GOOGLE_USER_EMAIL environment variable not set");
      return new Response(
        JSON.stringify({
          error: "Email service not configured. Please contact the site administrator.",
        }),
        {
          status: 500,
          headers: defaultHeaders,
        },
      );
    }

    let accessToken: string;
    try {
      accessToken = await getAccessToken();
      console.log("OAuth2 access token obtained successfully");
    } catch (error) {
      const oauthError = error instanceof Error ? error.message : String(error);
      console.error("Failed to get OAuth2 access token:", {
        error: oauthError,
        hasClientId: !!import.meta.env.GOOGLE_CLIENT_ID,
        hasClientSecret: !!import.meta.env.GOOGLE_CLIENT_SECRET,
        hasRefreshToken: !!import.meta.env.GOOGLE_REFRESH_TOKEN,
      });
    
      // Don't expose OAuth error details in production
      return new Response(
        JSON.stringify({
          error: "Email service authentication failed. Please try again later.",
        }),
        {
          status: 500,
          headers: defaultHeaders,
        },
      );
    }

    const clientId = import.meta.env.GOOGLE_CLIENT_ID;
    const clientSecret = import.meta.env.GOOGLE_CLIENT_SECRET;
    const refreshToken = import.meta.env.GOOGLE_REFRESH_TOKEN;

    if (!clientId || !clientSecret || !refreshToken) {
      console.error("OAuth2 credentials incomplete:", {
        hasClientId: !!clientId,
        hasClientSecret: !!clientSecret,
        hasRefreshToken: !!refreshToken,
      });
      return new Response(
        JSON.stringify({
          error: "Email service not configured. Please contact the site administrator.",
        }),
        {
          status: 500,
          headers: defaultHeaders,
        },
      );
    }

    const { google } = await import("googleapis");
    
    const redirectUri =
      import.meta.env.GOOGLE_REDIRECT_URI ||
      import.meta.env.PUBLIC_SITE_URL + "/callback" ||
      "http://localhost:3000/callback";
    
    const oauth2Client = new google.auth.OAuth2(
      clientId,
      clientSecret,
      redirectUri,
    );
    
    oauth2Client.setCredentials({
      refresh_token: refreshToken,
      access_token: accessToken,
    });
    
    const gmail = google.gmail({ version: "v1", auth: oauth2Client });

    // Sanitize HTML to prevent XSS
    const escapeHtml = (text: string) => {
      const map: Record<string, string> = {
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        '"': "&quot;",
        "'": "&#039;",
      };
      return text.replace(/[&<>"']/g, (m) => map[m]);
    };

    // Sanitize inputs for email headers to prevent header injection
    const sanitizedName = sanitizeEmailHeader(sanitizedData.name);
    const sanitizedEmail = sanitizeEmailHeader(sanitizedData.email);
    const sanitizedSubject = sanitizeEmailHeader(sanitizedData.subject);
    const sanitizedMessage = sanitizeEmailHeader(sanitizedData.message);

    const htmlMessage = `
      <h2>New Contact Form Submission</h2>
      <p><strong>From:</strong> ${escapeHtml(sanitizedName)} (${escapeHtml(sanitizedEmail)})</p>
      <p><strong>Subject:</strong> ${escapeHtml(sanitizedSubject)}</p>
      <p><strong>Message:</strong></p>
      <p>${escapeHtml(sanitizedMessage).replace(/\n/g, "<br>")}</p>
      <hr>
      <p style="color: #666; font-size: 12px;">This message was sent from the contact form on ${url.origin}</p>
    `;

    const textMessage = `
New Contact Form Submission

From: ${sanitizedName} (${sanitizedEmail})
Subject: ${sanitizedSubject}

Message:
${sanitizedMessage}

---
This message was sent from the contact form on ${url.origin}
    `;

    // Create email message using RFC 2822 format
    // Use sanitized values in headers to prevent header injection
    const emailMessage = [
      `From: "Contact Form" <${userEmail}>`,
      `To: ${recipientEmail}`,
      `Reply-To: ${sanitizedEmail}`,
      `Subject: Contact Form: ${sanitizedSubject}`,
      `Content-Type: text/html; charset=utf-8`,
      ``,
      htmlMessage,
    ].join("\r\n");

    // Encode message in base64url format (required by Gmail API)
    const encodedMessage = Buffer.from(emailMessage)
      .toString("base64")
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "");

    await gmail.users.messages.send({
      userId: "me",
      requestBody: {
        raw: encodedMessage,
      },
    });

    return new Response(
      JSON.stringify({
        success: true,
        message: "Message sent successfully",
      }),
      {
        status: 200,
        headers: {
          ...defaultHeaders,
          "X-RateLimit-Limit": "5",
          "X-RateLimit-Remaining": rateLimitResult.remaining.toString(),
          "X-RateLimit-Reset": new Date(rateLimitResult.resetTime).toISOString(),
        },
      },
    );
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : String(error);
    const errorName = error instanceof Error ? error.name : "UnknownError";
    
    console.error("Contact form error:", {
      name: errorName,
      message: errorMessage,
      stack: error instanceof Error ? error.stack : undefined,
    });
    
    return new Response(
      JSON.stringify({
        error: "Failed to send message. Please try again later.",
      }),
      {
        status: 500,
        headers: {
          "Content-Type": "application/json",
          ...corsHeaders,
        },
      },
    );
  }
};

// Handle OPTIONS request for CORS preflight
export const OPTIONS: APIRoute = async () => {
  return new Response(null, {
    status: 204,
    headers: getCORSHeaders(),
  });
};
