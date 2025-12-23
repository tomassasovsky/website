/**
 * Validates that a URL is safe to use in href attributes.
 * Rejects dangerous schemes like javascript:, data:, vbscript:, etc.
 * 
 * @param url - The URL string to validate
 * @returns true if the URL is safe, false otherwise
 */
export function isValidUrl(url: string): boolean {
  if (!url || typeof url !== "string") {
    return false;
  }

  try {
    // Use a base URL for relative URLs (works in both server and client contexts)
    const baseUrl = typeof window !== "undefined" ? window.location.href : "https://aquiles.dev";
    const parsed = new URL(url, baseUrl);
    const scheme = parsed.protocol.toLowerCase().replace(":", "");

    // List of dangerous schemes that should be rejected
    const dangerousSchemes = [
      "javascript",
      "data",
      "vbscript",
      "file",
      "about",
      "jar",
    ];

    // Reject dangerous schemes
    if (dangerousSchemes.includes(scheme)) {
      return false;
    }

    // Allow http, https, mailto, tel, and relative URLs (empty protocol)
    const allowedSchemes = ["http", "https", "mailto", "tel", ""];
    if (!allowedSchemes.includes(scheme)) {
      return false;
    }

    return true;
  } catch {
    // If URL parsing fails, it might be a relative URL
    // Check if it starts with dangerous patterns
    const trimmed = url.trim().toLowerCase();
    if (
      trimmed.startsWith("javascript:") ||
      trimmed.startsWith("data:") ||
      trimmed.startsWith("vbscript:") ||
      trimmed.startsWith("file:")
    ) {
      return false;
    }

    // Allow relative URLs (starting with /, #, or just a path)
    return true;
  }
}

/**
 * Sanitizes a URL by validating it and returning a safe version.
 * Returns the original URL if valid, or "#" if invalid.
 * 
 * @param url - The URL string to sanitize
 * @returns A safe URL string
 */
export function sanitizeUrl(url: string): string {
  if (isValidUrl(url)) {
    return url;
  }
  return "#";
}

/**
 * Validates an email address format.
 * 
 * @param email - The email string to validate
 * @returns true if the email format is valid, false otherwise
 */
export function isValidEmail(email: string): boolean {
  if (!email || typeof email !== "string") {
    return false;
  }

  // Basic email regex (RFC 5322 simplified)
  const emailRegex =
    /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;

  return emailRegex.test(email.trim());
}

