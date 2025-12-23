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

# Expose port (Astro defaults to 4321, but can be overridden)
ENV PORT=4321
EXPOSE 4321

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:' + (process.env.PORT || 4321) + '/', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the server
CMD ["node", "./dist/server/entry.mjs"]

