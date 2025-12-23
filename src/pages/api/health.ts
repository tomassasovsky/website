import type { APIRoute } from "astro";

/**
 * Health check endpoint for Docker healthchecks
 * Returns 200 OK if the server is running
 */
export const GET: APIRoute = async () => {
  return new Response(
    JSON.stringify({ status: "ok", timestamp: new Date().toISOString() }),
    {
      status: 200,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
};

