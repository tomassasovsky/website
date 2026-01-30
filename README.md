# Portfolio (Astro) – Fork & Personalize

An opinionated, single-page portfolio built with Astro. This README explains how to fork it and make it yours quickly.

## Quick start

1) Fork this repo, then clone your fork
```bash
git clone YOUR_FORK_URL portfolio && cd portfolio
```
2) Install and run
```bash
npm install
npm run dev
```
3) Open http://localhost:4321

## What to change (10–15 min)

- Site identity: update `src/data/site.ts`
  - `name`, `tagline`, `email`, `socials`, and UI headings.
- About: `src/data/about.ts`
  - Replace the paragraphs and services.
- Experience: `src/data/experience.ts`
- Clients: `src/data/clients.ts`
- Testimonials: `src/data/testimonials.ts`
- Projects: `src/data/projects.ts`
  - Edit project cards and `category` values. Categories shown are defined in `src/data/projectsFilters.ts`.
- Contact settings (if used): `src/data/contact.ts`

Assets (replace with your own):
- Avatar/headshot: `public/assets/images/me.jpg`
- Favicon(s): `public/assets/images/logo.ico` or `public/assets/images/ts-favicon.svg`
- Logos/preview images: `public/assets/images/*`

## SEO & social preview

- Set your canonical origin in `astro.config.mjs`:
```js
export default defineConfig({ site: 'https://your-domain.com' });
```
- The global head is handled in `src/layouts/BaseLayout.astro` (title, description, canonical, Open Graph, Twitter). Per‑tab titles/descriptions are set where the main shell/page defines `meta`.
- Sitemap is served from `src/pages/sitemap.xml.ts` (update the static routes if you add/remove sections).
- `public/robots.txt` allows indexing and points to `/sitemap.xml`.
- Share preview image: use a 1200×630 image. Point `og:image` to it in `BaseLayout` or set per‑page.

After deploy, refresh caches with sharing debuggers (Facebook, X/Twitter, LinkedIn).

## Navigation and sections

- Edit nav labels/links in `src/data/nav.ts`.
- Sections (About/Work/Projects/Contact) live in `src/components/tabs/`.
- The main shell that renders sidebar, navbar, and tabs lives in `src/components/MainShell.astro`.

## Styling

- Global CSS lives in `public/assets/css/style.css`. Tweak CSS variables (colors, shadows, font sizes) near the top to re‑theme quickly.

## Search (Projects)

This site is a single-page app (tabs). A lightweight **Projects search** is already wired up:

- UI: `src/components/tabs/ProjectsTab.astro` (`Search projects…` input)
- Logic: `src/components/PageInteractions.astro` (filters by **category + query**)

No extra setup is needed.

## Metrics / analytics

Because the site uses History API tab routing, the project includes an SPA pageview hook so analytics counts `/projects`, `/contact`, etc.

### Plausible

1) Paste the Plausible snippet into the `<head>` in `src/components/Analytics.astro`.

2) Deploy. Pageviews will be tracked on initial load + tab changes.

### Track conversions (contact form)

On successful contact form submission, the site fires an analytics event named `contact_submit`.

## Search Console verification (SEO metrics)

If you want Google/Bing indexing and performance reports:

- **Google Search Console**: set `PUBLIC_GOOGLE_SITE_VERIFICATION` to your verification token
- **Bing Webmaster Tools**: set `PUBLIC_BING_SITE_VERIFICATION` to your verification token

Those become `<meta>` tags in `src/layouts/BaseLayout.astro`.

## Deployment

Vercel (recommended)
```bash
npm run build
# push to Git; import repo in Vercel; set Framework: Astro
```

Netlify
```bash
# Build command: npm run build
# Publish directory: dist
```

GitHub Pages
```bash
npm run build
# Deploy ./dist via actions or a pages branch
```

Docker (optional)
```bash
docker build -t portfolio .
docker run -p 4321:4321 portfolio
```

## License

MIT. Please keep a credit link in your README if you use this as a base.
