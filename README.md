# NestJS Production Boilerplate

A production-ready NestJS boilerplate designed for cloud-native distributed architectures. This starter provides a solid foundation for building scalable backend applications with modern development practices and flexible cloud deployment options.

## What is This?

This boilerplate provides a complete backend application setup with:

- **Local Development**: Run NestJS natively on your machine for fast iteration, with Docker handling only infrastructure services (PostgreSQL, Redis, pgAdmin)
- **Type Safety**: Full TypeScript support with strict typing and ORM integration
- **Database Management**: TypeORM with migration support for structured schema evolution
- **Authentication Ready**: Pre-configured authentication and user management modules
- **Cloud-Native**: Designed for distributed deployments with support for managed databases and Redis instances
- **CI/CD Ready**: Prepared for automated testing, building, and deployment pipelines
- **Production Optimized**: Multi-stage Docker builds producing minimal, secure production images
- **Platform Agnostic**: Deploy to Railway, Render, AWS, Google Cloud, or any Docker-compatible platform


---

## Technology Stack

<p align="center">
  <img src="https://cdn.worldvectorlogo.com/logos/nestjs.svg" alt="NestJS" height="60"/>
  <img src="https://cdn.worldvectorlogo.com/logos/postgresql.svg" alt="PostgreSQL" height="60"/>
  <img src="https://typeorm.io/img/typeorm-icon-colored.png" alt="TypeORM" height="60"/>
  <img src="https://www.postgresql.org/message-id/attachment/1139/pgAdmin.svg" alt="pgAdmin" height="60"/>
  <img src="https://cdn.worldvectorlogo.com/logos/redis.svg" alt="Redis" height="60"/>
  <img src="https://cdn.worldvectorlogo.com/logos/docker.svg" alt="Docker" height="60"/>
</p>

### Core Technologies

**NestJS** - Progressive Node.js framework for building efficient and scalable server-side applications

**PostgreSQL** - Advanced open-source relational database with strong data integrity

**TypeORM** - Modern TypeScript ORM with migrations, active record, and data mapper patterns

**Redis** - In-memory data structure store for caching and session management

**Docker** - Containerization for infrastructure services (development) and application deployment (production)

**pgAdmin** - Web-based PostgreSQL administration tool (development only)

---

## Prerequisites

- Node.js 18 or higher
- pnpm 8 or higher
- Docker Desktop (for infrastructure services)
- Git

---

## Quick Start

### 1. Clone and Install

```bash
git clone https://github.com/mariuscozma11/nestjs-boilerplate
cd nestjs-boilerplate
pnpm install
```

### 2. Configure Environment

Copy the `.env` file and update values as needed:

```bash
cp .env .env.local
```

The default configuration works out of the box for local development.

### 3. Start Infrastructure Services

```bash
pnpm dev:services
```

This starts PostgreSQL, Redis, and pgAdmin using Docker Compose.

### 4. Run Database Migrations

```bash
pnpm migration:run
```

### 5. Start the Application

```bash
pnpm dev
```

The API will be available at `http://localhost:3000`

---

## Development Workflow

### Starting Development

```bash
# Start infrastructure (PostgreSQL, Redis, pgAdmin)
pnpm dev:services

# Start the application with hot-reload
pnpm dev
```

### Managing Services

```bash
# View service logs
pnpm dev:services:logs

# Stop services
pnpm dev:services:down

# Reset services (removes all data)
pnpm dev:reset
```

### Database Migrations

```bash
# Generate a new migration based on entity changes
pnpm migration:generate AddUserTable

# Run pending migrations
pnpm migration:run

# Revert the last migration
pnpm migration:revert

# Show migration status
pnpm migration:show
```

### Installing Dependencies

```bash
# Add a new package
pnpm add <package-name>

# Add a dev dependency
pnpm add -D <package-name>
```

Dependencies are installed directly on your host machine, no Docker rebuild needed.

---

## Available Services

### Application
- **URL**: http://localhost:3000
- **Environment**: Development with hot-reload

### PostgreSQL
- **Host**: localhost
- **Port**: 5432
- **Database**: nestjs-bp
- **User**: postgres
- **Password**: (see `.env`)

### Redis
- **Host**: localhost
- **Port**: 6379

### pgAdmin
- **URL**: http://localhost:5050
- **Email**: (see `.env`)
- **Password**: (see `.env`)

---

## Project Structure

```
nestjs-boilerplate/
├── src/
│   ├── auth/              # Authentication module
│   ├── users/             # User management module
│   ├── db/
│   │   ├── datasource.ts  # TypeORM configuration
│   │   └── migrations/    # Database migrations
│   ├── app.module.ts      # Root application module
│   └── main.ts            # Application entry point
├── scripts/
│   └── generate-migration.js  # Migration helper script
├── test/                  # E2E tests
├── .env                   # Environment configuration
├── docker-compose.yml     # Infrastructure services
├── Dockerfile             # Production build
└── package.json           # Dependencies and scripts
```

---

## Testing

```bash
# Run unit tests
pnpm test

# Run tests in watch mode
pnpm test:watch

# Run tests with coverage
pnpm test:cov

# Run e2e tests
pnpm test:e2e
```

---

## Production Deployment

This boilerplate is designed for flexible cloud-native deployment. Choose the platform that fits your needs for production:

### Deployment Options

**Simplest (Recommended for Getting Started)**
- **Railway** or **Render**: All-in-one platform with built-in PostgreSQL and Redis
- **Database**: Platform-provided PostgreSQL
- **Cache**: Platform-provided Redis or Upstash (free tier)
- **Cost**: $0-15/month or free tier

**Cloud Providers (Production Scale)**
- **AWS**: ECS Fargate + RDS + ElastiCache
- **Google Cloud**: Cloud Run + Cloud SQL + Memorystore
- **Azure**: Container Apps + Database + Cache
- **Cost**: Varies, free tier available for 6 months on AWS


### Building Production Image

```bash
# Build optimized production Docker image
pnpm build:docker

# Or manually
docker build -t nestjs-boilerplate:latest .
```

---

## Scripts Reference

### Development
- `pnpm dev` - Start application with hot-reload
- `pnpm dev:services` - Start infrastructure services
- `pnpm dev:services:down` - Stop infrastructure services
- `pnpm dev:services:logs` - View service logs
- `pnpm dev:reset` - Reset infrastructure (removes data)

### Building
- `pnpm build` - Build application
- `pnpm build:docker` - Build production Docker image

### Testing
- `pnpm test` - Run unit tests
- `pnpm test:watch` - Run tests in watch mode
- `pnpm test:cov` - Run tests with coverage
- `pnpm test:e2e` - Run end-to-end tests

### Database
- `pnpm migration:generate <name>` - Generate migration
- `pnpm migration:run` - Run migrations
- `pnpm migration:revert` - Revert last migration
- `pnpm migration:show` - Show migration status

### Code Quality
- `pnpm lint` - Lint and fix code
- `pnpm format` - Format code with Prettier

---

## License

[MIT](LICENSE) (c) 2025 - mariuscozma11
