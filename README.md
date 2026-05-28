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
- Avatar: `web/assets/images/profile.png`
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

## Contact form & meeting booking

Copy `.env.example` to `.env` and fill in the Google OAuth credentials. The same refresh token is used for:

- **Contact form** — sends email via Gmail API
- **Meeting booking** — reads availability and creates calendar events via Google Calendar API

### Google OAuth setup

1. Create a Google Cloud project and enable **Gmail API** and **Google Calendar API**.
2. Create OAuth 2.0 credentials (Web application or Desktop).
3. Authorize with these scopes:
   - `https://www.googleapis.com/auth/gmail.send`
   - `https://www.googleapis.com/auth/calendar.events`
   - `https://www.googleapis.com/auth/calendar.freebusy`
4. Store the refresh token in `GOOGLE_REFRESH_TOKEN`.

If you already have a Gmail-only refresh token, re-authorize with the Calendar scopes above.

### Quick setup script

1. In Google Cloud Console, create a **Web application** OAuth client.
2. Add `http://localhost:8080` to **Authorized redirect URIs**.
3. Put `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` in `.env`.
4. Stop the dev server (it uses the same port), then run:

```bash
dart run tool/google_oauth_setup.dart --write
```

The script opens your browser, captures the callback, and writes `GOOGLE_REFRESH_TOKEN` to `.env`.

### Booking configuration

| Variable | Default | Description |
|---|---|---|
| `GOOGLE_CALENDAR_ID` | `primary` | Calendar to book against |
| `BOOKING_TIMEZONE` | `America/Argentina/Buenos_Aires` | IANA timezone for events |
| `BOOKING_UTC_OFFSET_HOURS` | `-3` | Offset used for slot generation |
| `BOOKING_DURATION_MINUTES` | `30` | Meeting length |
| `BOOKING_START_HOUR` | `9` | First slot (local time) |
| `BOOKING_END_HOUR` | `17` | Last slot start boundary |
| `BOOKING_DAYS_AHEAD` | `14` | How far ahead users can book |
| `BOOKING_MIN_NOTICE_MINUTES` | `1440` | Minimum lead time before a slot (1440 = 24 hours) |
| `BOOKING_WORK_DAYS_ONLY` | `true` | Skip weekends |

Without credentials, the booking UI still works locally — slots are shown and submissions are logged to stderr instead of creating calendar events.

Set `BOOKING_DEBUG=true` in `.env` for verbose server logs and error details in API responses.

When Google credentials are configured, the **guest** receives Google’s native calendar invite (`sendUpdates=all`). The **host** (`CONTACT_EMAIL` or `GOOGLE_USER_EMAIL`) receives an HTML notification styled like Google Calendar — with Meet link and an **Open in Google Calendar** link scoped to the organizer’s calendar (guest invite links use a different `eid` and won’t open for the host). Gmail does not show “Add to calendar” for the organizer because the event is already on their calendar.

## License

MIT. Please keep a credit link in your README if you use this as a base.
