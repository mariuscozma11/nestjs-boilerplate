<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest


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
