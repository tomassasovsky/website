# ─────────────────────────────────────────────────────────────────────────────
# Stage 1 – build
# Uses jaspr_cli to compile server (AOT) + client (dart2js) in one step.
# Output lands in /app/build/jaspr/
# ─────────────────────────────────────────────────────────────────────────────
FROM dart:3.12.1 AS build
WORKDIR /app

# Cache pub deps before copying source
COPY pubspec.* ./
RUN dart pub get --enforce-lockfile

COPY . .

# Run the CLI from the same locked dependency graph as the build daemon.
RUN dart run jaspr_cli:jaspr build

# ─────────────────────────────────────────────────────────────────────────────
# Stage 2 – runtime
# FROM scratch + the Dart minimal runtime = tiny final image (~10 MB)
# ─────────────────────────────────────────────────────────────────────────────
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/build/jaspr/ /app/
WORKDIR /app

# Jaspr server listens on 8080 by default (override with PORT)
EXPOSE 8080

CMD ["./app"]
