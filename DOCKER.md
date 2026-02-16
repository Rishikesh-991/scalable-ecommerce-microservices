# Docker Guide

## 1. Goals

This guide standardizes container usage for local development and production-ready image practices.

## 2. Docker Compose workflow

Use Docker Compose to run foundational dependencies and shared runtime services.

```bash
# Start
docker-compose up -d

# Status
docker-compose ps

# Logs
docker-compose logs -f

# Stop
docker-compose down
```

## 3. Environment configuration

- Keep sensitive values in `.env` files excluded from source control.
- Use explicit variable names and service-specific prefixes.
- Never commit production secrets.

Example:

```bash
# .env example (do not commit real secrets)
MONGO_URI=mongodb://user:password@host:27017/ecommerce
POSTGRES_URI=postgresql://user:password@host:5432/ecommerce
REDIS_URL=redis://:password@host:6379
RABBITMQ_URL=amqp://user:password@host:5672
```

## 4. Image build best practices

### 4.1 Multi-stage build pattern

```dockerfile
# Stage 1: build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: runtime
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY package*.json ./
RUN npm ci --omit=dev
CMD ["node", "dist/index.js"]
```

### 4.2 Security and performance

- Use slim/alpine base images where possible.
- Pin base image tags.
- Run as non-root user in final stage.
- Keep image layers deterministic (`npm ci`, locked dependencies).
- Scan images in CI before publishing.

## 5. Build and tag strategy

```bash
# Example image build
docker build -t ecommerce/products:local ./products-cna-microservice

# Tagging pattern for CI
docker tag ecommerce/products:local ghcr.io/<org>/products:<git-sha>
```

Recommended tags:
- `:<git-sha>` immutable deployment tag
- `:main` rolling integration tag
- Avoid using `:latest` in production rollouts

## 6. Troubleshooting

- Port conflicts: `lsof -i :<port>`
- Stale cache: `docker builder prune`
- Broken environment: recreate with `docker-compose down -v && docker-compose up -d`

## 7. Related docs

- [QUICK_START.md](./QUICK_START.md)
- [KUBERNETES.md](./KUBERNETES.md)
- [SECURITY.md](./SECURITY.md)
