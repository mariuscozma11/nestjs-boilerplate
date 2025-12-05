# Technology Stack

## Backend Framework

### <img src="https://cdn.worldvectorlogo.com/logos/nestjs.svg" alt="NestJS" height="40" style="vertical-align: middle;"/> NestJS

A progressive Node.js framework for building efficient, reliable and scalable server-side applications.

## Database & ORM

### <img src="https://cdn.worldvectorlogo.com/logos/postgresql.svg" alt="PostgreSQL" height="40" style="vertical-align: middle;"/> PostgreSQL

Powerful, open-source relational database system with strong reliability and data integrity.

### <img src="https://typeorm.io/img/typeorm-icon-colored.png" alt="TypeORM" height="40" style="vertical-align: middle;"/> TypeORM

Modern ORM for TypeScript and JavaScript, supporting multiple databases with migrations and entity management.

## Database Administration

### <img src="https://www.postgresql.org/message-id/attachment/1139/pgAdmin.svg" alt="pgAdmin" height="40" style="vertical-align: middle;"/> pgAdmin

Web-based administration tool for PostgreSQL databases (development only).

## Caching & Queue

### <img src="https://cdn.worldvectorlogo.com/logos/redis.svg" alt="Redis" height="40" style="vertical-align: middle;"/> Redis

In-memory data structure store for caching, session management, and message queuing.

## Containerization

### <img src="https://cdn.worldvectorlogo.com/logos/docker.svg" alt="Docker" height="40" style="vertical-align: middle;"/> Docker

Multi-stage Docker setup with separate development and production configurations.

# Docker Workflow

## Development

```bash
# Start all services (app, db, redis, pgadmin)
docker-compose up
```

```bash
# Start in background
docker-compose up -d
```

```bash
# Rebuild and start
docker-compose up --build
```

```bash
# Stop all services
docker-compose down
```

```bash
# Stop and remove volumes (fresh start)
docker-compose down -v
```

```bash
# View logs
docker-compose logs -f app
```

**What runs:**

- App with hot-reload (source code mounted)
- PostgreSQL + pgAdmin
- Redis
- All ports exposed to host

---

## Production

```bash
# Start production services
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

```bash
# Rebuild and start
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d
```

```bash
# Stop
docker-compose -f docker-compose.yml -f docker-compose.prod.yml down
```

```bash
# View logs
docker-compose -f docker-compose.yml -f docker-compose.prod.yml logs -f app
```

**What runs:**

- Optimized production image (no source code volumes)
- PostgreSQL + Redis (no exposed ports)
- No pgAdmin
- Auto-restart on failure

---

## Common Commands

```bash
# Access app container shell
docker-compose exec app sh
```

```bash
# Run migrations
docker-compose exec app pnpm run migration:run
```

```bash
# View all containers
docker ps
```

```bash
# View images
docker images
```

```bash
# Check image sizes
docker images | grep nestjs-boilerplate
```

---

## Build Images Only (No Run)

```bash
# Build dev image
docker build --target development -t nestjs-boilerplate:dev .
```

```bash
# Build prod image
docker build --target production -t nestjs-boilerplate:prod .
```
