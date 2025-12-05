##############
# BASE STAGE #
##############
# Common base image with pnpm for all stages
FROM node:18-alpine AS base

# Install pnpm globally
RUN npm install -g pnpm

WORKDIR /app

# Copy package files for dependency installation
COPY package.json pnpm-lock.yaml ./


#####################
# DEVELOPMENT STAGE #
#####################
# For local development with hot-reload
FROM base AS development

# Install ALL dependencies (including devDependencies)
RUN pnpm install --frozen-lockfile

# Copy source code (in dev, this will be overridden by volume mount)
COPY . .

# Expose port for the application
EXPOSE 3000

# Expose port for debugging (optional)
EXPOSE 9229

# Run the app in development mode with hot-reload
CMD ["pnpm", "run", "start:dev"]


###############
# BUILD STAGE #
###############
# Build the production-ready application
FROM base AS build

# Install ALL dependencies first (needed for build)
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN pnpm run build

# Now install only production dependencies in a clean directory
# This removes devDependencies to keep the final image smaller
RUN pnpm install --frozen-lockfile --prod


####################
# PRODUCTION STAGE #
####################
# Final minimal image for production
FROM node:18-alpine AS production

# Install pnpm in production stage
RUN npm install -g pnpm

WORKDIR /app

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nestjs -u 1001

# Copy only the necessary files from build stage
# Copy built application
COPY --from=build --chown=nestjs:nodejs /app/dist ./dist

# Copy production node_modules
COPY --from=build --chown=nestjs:nodejs /app/node_modules ./node_modules

# Copy package.json (needed for running the app)
COPY --from=build --chown=nestjs:nodejs /app/package.json ./package.json

# Switch to non-root user
USER nestjs

# Expose application port
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/healthcheck', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the application in production mode
CMD ["node", "dist/main.js"]
