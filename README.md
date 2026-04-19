# Portfolio – Fork & Personalize

An opinionated personal portfolio built with [Jaspr](https://docs.page/schultek/jaspr) and Dart. Server-side rendered, with client-side hydration, i18n (English + Spanish), and a dark/light theme. This README explains how to fork it and make it yours.

## Tech stack

| Layer | Tool |
|---|---|
| Framework | [Jaspr](https://docs.page/schultek/jaspr) (server mode) |
| Language | Dart ≥ 3.11 |
| State | [jaspr_riverpod](https://pub.dev/packages/jaspr_riverpod) |
| Routing | [jaspr_router](https://pub.dev/packages/jaspr_router) |
| i18n | [slang](https://pub.dev/packages/slang) |
| Styling | Plain CSS (`web/styles.css`) |
| Deployment | Docker + scratch image |

## Quick start

1. Fork this repo, then clone your fork:
```bash
git clone YOUR_FORK_URL portfolio && cd portfolio
```
2. Get dependencies:
```bash
dart pub get
```
3. Generate code (i18n strings + Jaspr builder output):
```bash
dart run build_runner build
```
4. Run the dev server:
```bash
dart run lib/main.server.dart
```
5. Open http://localhost:8080

## What to change (10–15 min)

### Site identity
- **`lib/data/site_data.dart`** — `siteName`, `siteAvatar`, and social links.
- **`lib/data/contact_data.dart`** — booking/calendar URL.
- **`lib/data/portfolio_content.dart`** — services list shown on the home page.

### Clients & projects
- **`lib/data/clients_data.dart`** — client logos and URLs.
- **`lib/data/project_catalog.dart`** — project cover images, tech stack, categories, and links.

### Copy / translations
- **`lib/l10n/arb/en.arb`** — all English strings (name, tagline, about text, project titles/descriptions, etc.).
- **`lib/l10n/arb/es.arb`** — Spanish equivalents.

After editing ARB files, regenerate:
```bash
dart run slang
dart run build_runner build
```

### Assets
- Avatar: `web/assets/images/profile.jpg`
- Favicon: `web/favicon.svg` (or `web/favicon.ico`)
- Client logos & project covers: `web/assets/images/`

## Styling

Global CSS lives in `web/styles.css`. CSS custom properties (colors, shadows, radii) are near the top — tweak those to re-theme quickly. Light/dark theme tokens are in `[data-theme="light"]`.

## Analytics

The project ships a [Plausible](https://plausible.io) Docker Compose file (`plausible-docker-compose.yml`). To enable:

1. Fill in the required env vars in that file.
2. Add the Plausible script tag to `lib/app.dart` (inside the `Document` head).

## Deployment

### Docker (recommended)
```bash
docker build -t portfolio .
docker run -p 8080:8080 portfolio
```

The multi-stage `Dockerfile` compiles a minimal scratch-based image (~10 MB).

### Docker Compose
```bash
docker-compose up --build
```

### Manual (AOT binary)
```bash
dart pub global activate jaspr_cli
dart pub global run jaspr_cli:jaspr build
./build/jaspr/app
```

The server listens on port **8080** by default. Override with the `JASPR_PORT` environment variable.

## Project structure

```
lib/
  app.dart                  # Root Jaspr component (Document shell, router)
  data/                     # All content data (edit these to personalise)
  components/               # Reusable UI components
  pages/                    # Route-level page components
  l10n/                     # i18n: ARB source files + slang-generated code
  middleware/               # Shelf middleware (locale redirect, dev asset server)
  models/                   # Shared data models
web/
  styles.css                # Global stylesheet
  theme.js                  # Dark/light theme toggle + view-transition
  scroll-avatar.js          # Navbar avatar scroll behavior
  assets/
    images/                 # All image assets served at /assets/images/
    theme-switch.json       # Lottie animation for theme button
public/
  robots.txt
  assets/images/            # Static fallback copies of core images
```

## License

MIT. Please keep a credit link in your README if you use this as a base.
