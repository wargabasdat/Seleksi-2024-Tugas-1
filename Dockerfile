FROM node:20-alpine AS base

# APP SECTION
# Install dependency
FROM base AS app_deps
RUN apk add --no-cache bash
WORKDIR /app
COPY ./data-visualization/package.json ./
COPY ./data-visualization/package-lock.json ./
RUN npm ci

# Development (cache soruce )
FROM app_deps AS app_dev
WORKDIR /app
COPY ./data-visualization ./

# Build for production
FROM app_deps as app_builder
WORKDIR /app
COPY ./data-visualization ./
ENV NEXT_TELEMETRY_DISABLED 1
RUN npm run build

# Run for production
FROM base as app_runner
WORKDIR /app
# Uncomment the following line in case you want to disable telemetry during runtime.
ENV NEXT_TELEMETRY_DISABLED 1
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
COPY --from=app_builder /app/public ./public
# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=app_builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=app_builder --chown=nextjs:nodejs /app/.next/static ./.next/static
USER nextjs
CMD ["node", "server.js"]


# SCHEDULER SECTION
FROM base AS scheduler_deps
WORKDIR /app
COPY ./scheduler/package.json ./
COPY ./scheduler/package-lock.json ./
RUN npm ci

# Runner
FROM scheduler_deps AS scheduler_runner
# Install dependencies
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    yarn
# Tell Puppeteer to use the installed Chrome instead of downloading its own
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
WORKDIR /app
COPY ./scheduler ./
CMD ["npx", "tsx", "scheduler.ts"]