/**
 * Security utilities for API endpoints
 */

import { randomBytes } from "crypto";

/**
 * Rate limiting storage (in-memory, resets on server restart)
 * For production, consider using Redis or a database
 */
const rateLimitStore = new Map<string, { count: number; resetTime: number }>();

/**
 * Rate limiting configuration
 */
const RATE_LIMIT = {
  maxRequests: 5, // Maximum requests per window
  windowMs: 60 * 1000, // 1 minute window
};

/**
 * Check if request should be rate limited
 * @param identifier - IP address or other unique identifier
 * @returns true if rate limit exceeded, false otherwise
 */
export function checkRateLimit(identifier: string): {
  allowed: boolean;
  remaining: number;
  resetTime: number;
} {
  const now = Date.now();
  const record = rateLimitStore.get(identifier);

  if (!record || now > record.resetTime) {
    rateLimitStore.set(identifier, {
      count: 1,
      resetTime: now + RATE_LIMIT.windowMs,
    });
    return {
      allowed: true,
      remaining: RATE_LIMIT.maxRequests - 1,
      resetTime: now + RATE_LIMIT.windowMs,
    };
  }

  if (record.count >= RATE_LIMIT.maxRequests) {
    return {
      allowed: false,
      remaining: 0,
      resetTime: record.resetTime,
    };
  }

  record.count++;
  rateLimitStore.set(identifier, record);

  return {
    allowed: true,
    remaining: RATE_LIMIT.maxRequests - record.count,
    resetTime: record.resetTime,
  };
}

/**
 * Get client IP address from request
 * Handles various proxy headers
 */
export function getClientIP(request: Request): string {
  // Check various headers that proxies might set
  const forwarded = request.headers.get("x-forwarded-for");
  if (forwarded) {
    // Take the first IP in the chain
    return forwarded.split(",")[0].trim();
  }

  const realIP = request.headers.get("x-real-ip");
  if (realIP) {
    return realIP.trim();
  }

  // Fallback (in serverless environments, this might not be available)
  return "unknown";
}

/**
 * Sanitize email headers to prevent header injection
 * Removes newlines, carriage returns, and other dangerous characters
 */
export function sanitizeEmailHeader(value: string): string {
  if (!value || typeof value !== "string") {
    return "";
  }
  // Remove newlines, carriage returns, and null bytes
  return value
    .replace(/[\r\n]/g, "")
    .replace(/\0/g, "")
    .trim()
    .slice(0, 1000); // Limit header length
}

/**
 * Validate Content-Type header
 */
export function isValidContentType(request: Request): boolean {
  const contentType = request.headers.get("content-type");
  if (!contentType) {
    return false;
  }
  // Allow application/json and application/json; charset=utf-8
  return contentType.toLowerCase().startsWith("application/json");
}

/**
 * Generate CSRF token using cryptographically secure random bytes
 * Uses Node.js crypto.randomBytes for production-ready token generation
 */
export function generateCSRFToken(): string {
  // Use Node.js crypto.randomBytes for cryptographically secure random tokens
  // 32 bytes = 256 bits of entropy, hex encoded = 64 character token
  return randomBytes(32).toString("hex");
}

/**
 * Validate request body size
 */
export function validateBodySize(body: string, maxSize: number = 10000): boolean {
  return body.length <= maxSize;
}

/**
 * Input length limits
 */
export const INPUT_LIMITS = {
  name: { min: 2, max: 100 },
  email: { min: 5, max: 254 }, // RFC 5321 max email length
  subject: { min: 3, max: 200 },
  message: { min: 10, max: 5000 },
};

/**
 * Validate input lengths
 */
export function validateInputLengths(data: {
  name: string;
  email: string;
  subject: string;
  message: string;
}): { valid: boolean; errors: string[] } {
  const errors: string[] = [];

  if (data.name.length < INPUT_LIMITS.name.min) {
    errors.push(`Name must be at least ${INPUT_LIMITS.name.min} characters`);
  }
  if (data.name.length > INPUT_LIMITS.name.max) {
    errors.push(`Name must be no more than ${INPUT_LIMITS.name.max} characters`);
  }

  if (data.email.length < INPUT_LIMITS.email.min) {
    errors.push(`Email must be at least ${INPUT_LIMITS.email.min} characters`);
  }
  if (data.email.length > INPUT_LIMITS.email.max) {
    errors.push(`Email must be no more than ${INPUT_LIMITS.email.max} characters`);
  }

  if (data.subject.length < INPUT_LIMITS.subject.min) {
    errors.push(`Subject must be at least ${INPUT_LIMITS.subject.min} characters`);
  }
  if (data.subject.length > INPUT_LIMITS.subject.max) {
    errors.push(`Subject must be no more than ${INPUT_LIMITS.subject.max} characters`);
  }

  if (data.message.length < INPUT_LIMITS.message.min) {
    errors.push(`Message must be at least ${INPUT_LIMITS.message.min} characters`);
  }
  if (data.message.length > INPUT_LIMITS.message.max) {
    errors.push(`Message must be no more than ${INPUT_LIMITS.message.max} characters`);
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}

/**
 * CORS headers for API responses
 */
export function getCORSHeaders(): Record<string, string> {
  return {
    "Access-Control-Allow-Origin": import.meta.env.PUBLIC_SITE_URL || "*",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Max-Age": "86400", // 24 hours
  };
}

