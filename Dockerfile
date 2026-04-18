# ─────────────────────────────────────────────────────────────────────────────
# Stage 1 – build
# Uses jaspr_cli to compile server (AOT) + client (dart2js) in one step.
# Output lands in /app/build/jaspr/
# ─────────────────────────────────────────────────────────────────────────────
FROM dart:stable AS build
RUN dart pub global activate jaspr_cli
WORKDIR /app

# Cache pub deps before copying source
COPY pubspec.* ./
RUN dart pub get

COPY . .

# Drop any local overrides that could break the production build
RUN rm -f pubspec_overrides.yaml

RUN dart pub global run jaspr_cli:jaspr build

# ─────────────────────────────────────────────────────────────────────────────
# Stage 2 – runtime
# FROM scratch + the Dart minimal runtime = tiny final image (~10 MB)
# ─────────────────────────────────────────────────────────────────────────────
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/build/jaspr/ /app/
WORKDIR /app

# Jaspr server listens on 8080 by default (override with JASPR_PORT)
EXPOSE 8080

CMD ["./app"]
