###################
# BASE STAGE
###################
FROM node:18-alpine AS base

# Install pnpm globally
RUN npm install -g pnpm

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml ./


###################
# BUILD STAGE
###################
FROM base AS build

# Install ALL dependencies (needed for build)
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN pnpm run build

# Verify build succeeded
RUN ls -la dist/

# Prune dev dependencies for production
RUN pnpm prune --prod


###################
# PRODUCTION STAGE
###################
FROM node:18-alpine AS production

# Install pnpm
RUN npm install -g pnpm

WORKDIR /app

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nestjs -u 1001

# Copy built application from build stage
COPY --from=build --chown=nestjs:nodejs /app/dist ./dist

# Copy production node_modules
COPY --from=build --chown=nestjs:nodejs /app/node_modules ./node_modules

# Copy package.json
COPY --from=build --chown=nestjs:nodejs /app/package.json ./package.json

# Verify files were copied
RUN ls -la && ls -la dist/

# Switch to non-root user
USER nestjs

# Expose application port
EXPOSE 3000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/healthcheck', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the application in production mode
CMD ["node", "dist/main.js"]
