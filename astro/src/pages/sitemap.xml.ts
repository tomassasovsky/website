import type { APIRoute } from "astro";

const routes = ["/about", "/work", "/projects", "/contact"]; // static sections

export const GET: APIRoute = async ({ url }) => {
  const origin = url.origin.replace(/\/$/, "");
  const updated = new Date().toISOString();
  const urls = routes
    .map((path) => {
      const loc = origin + path;
      return `<url><loc>${loc}</loc><changefreq>weekly</changefreq><priority>0.8</priority><lastmod>${updated}</lastmod></url>`;
    })
    .join("");
  const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${urls}</urlset>`;
  return new Response(xml, {
    headers: {
      "Content-Type": "application/xml; charset=utf-8",
      "Cache-Control": "public, max-age=3600",
    },
  });
};
