# Docker file for Railway specific root directory
FROM node:20-alpine AS scheduler_deps
WORKDIR /app
COPY ./package.json ./
COPY ./package-lock.json ./
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
COPY ./ ./
CMD ["npx", "tsx", "scheduler.ts"]