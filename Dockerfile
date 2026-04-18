# ─────────────────────────────────────────────────────────────────────────────
# Stage 1 – build
# ─────────────────────────────────────────────────────────────────────────────
FROM dart:stable AS build
WORKDIR /app

# Cache pub dependencies before copying source
COPY pubspec.* ./
RUN dart pub get

# Copy source, then compile Dart → JS (dart2js, release mode) for client hydration
COPY . .
RUN dart run build_runner build --release --delete-conflicting-outputs

# Compile the server to a native AOT binary (no Dart SDK needed at runtime)
RUN dart compile exe lib/main.server.dart -o bin/server

# ─────────────────────────────────────────────────────────────────────────────
# Stage 2 – runtime (minimal Debian image, no Dart SDK required)
# ─────────────────────────────────────────────────────────────────────────────
FROM debian:bookworm-slim AS runtime
WORKDIR /app

# AOT server binary
COPY --from=build /app/bin/server ./server

# Static web assets (CSS, images, favicon, scroll-avatar.js)
COPY --from=build /app/web ./web

# Compiled client-side JS – Jaspr's middleware reads from this path at runtime
COPY --from=build /app/.dart_tool/build/generated/website/web/ \
                  ./.dart_tool/build/generated/website/web/

# Jaspr server listens on 8080 by default (override with JASPR_PORT)
EXPOSE 8080

CMD ["./server"]
