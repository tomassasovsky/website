FROM node:20-bookworm-slim AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --no-fund

# Build the site
COPY . .
RUN npm run build

# --- Runtime image: Node.js server ---
FROM node:20-bookworm-slim AS runtime
WORKDIR /app

# Copy package files and install production dependencies only
COPY package*.json ./
RUN npm ci --only=production --no-fund

# Copy built application
COPY --from=build /app/dist ./dist

# Copy healthcheck and startup scripts
COPY healthcheck.js ./
COPY start-server.js ./

# Expose port (Astro defaults to 4321, but can be overridden)
# Set HOST to 0.0.0.0 to listen on all interfaces (required for Docker)
ENV PORT=4321
ENV HOST=0.0.0.0
EXPOSE 4321

# Healthcheck - wait longer for server to start, then check every 30s
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD node healthcheck.js

# Start the server - the adapter auto-starts when entry.mjs is imported
# Ensure HOST and PORT are set for Docker networking
CMD ["sh", "-c", "HOST=${HOST:-0.0.0.0} PORT=${PORT:-4321} node ./dist/server/entry.mjs"]

