FROM node:20-bookworm-slim AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --no-fund

# Build the site
COPY . .
RUN npm run build

# --- Runtime image: serve static files with nginx ---
FROM nginx:alpine AS runtime

# Copy nginx configuration with security headers
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built site to nginx html directory
COPY --from=build /app/dist/ /usr/share/nginx/html

# Healthcheck (optional)
HEALTHCHECK CMD wget --spider -q http://localhost/ || exit 1

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

