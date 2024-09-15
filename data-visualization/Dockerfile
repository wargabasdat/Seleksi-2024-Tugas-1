# Install dependency
FROM node:20-alpine AS app_deps
RUN apk add --no-cache bash
WORKDIR /app
ARG src="./data-visualization"
COPY ${src}/package.json .
COPY ${src}/package-lock.json .
RUN npm ci

# Development (cache soruce )
FROM app_deps AS app_dev
WORKDIR /app
ARG src="./data-visualization"
COPY ${src} .

# Build for production
FROM app_deps as app_builder
WORKDIR /app
ARG src="./data-visualization"
COPY ${src} .
ENV NEXT_TELEMETRY_DISABLED 1
RUN npm run build

# Run for production
FROM node:20-alpine as app_runner
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