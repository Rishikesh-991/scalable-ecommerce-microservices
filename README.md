# Scalable E-Commerce Microservices

Production-style e-commerce platform built with a polyglot microservices architecture (Node.js, Spring Boot, FastAPI, React), containerized with Docker, and prepared for Kubernetes deployment.

## Why this project matters

This repository demonstrates real-world software engineering concerns beyond CRUD APIs:
- Service decomposition and polyglot backend design
- Async/event-oriented integration patterns
- Multi-database architecture (MongoDB, PostgreSQL, Redis)
- Dockerized local environments and Kubernetes-ready deployment
- Platform documentation expected in industry teams

## Implemented services

| Service | Stack | Default Port | Purpose |
|---|---|---:|---|
| `products-cna-microservice` | Node.js + Express | 5000 | Product catalog and inventory data |
| `cart-cna-microservice` | Spring Boot | 8080 | Cart operations and pricing workflow |
| `users-cna-microservice` | FastAPI | 9090 | User lifecycle and user APIs |
| `search-cna-microservice` | Node.js | 4000 | Search gateway / search integration |
| `store-ui` | React | 3000 | Customer web UI |

## Documentation index

Start here, then go deeper by topic:

- **[QUICK_START.md](./QUICK_START.md)** — local setup, Docker, Kubernetes, Terraform entry points
- **[ARCHITECTURE.md](./ARCHITECTURE.md)** — architecture views, request/data flow, trade-offs
- **[DOCKER.md](./DOCKER.md)** — image strategy, compose usage, environment handling
- **[KUBERNETES.md](./KUBERNETES.md)** — Helm charts, manifests, deployment strategy
- **[TERRAFORM.md](./TERRAFORM.md)** — infrastructure-as-code structure and workflow
- **[MONITORING.md](./MONITORING.md)** — Prometheus/Grafana, health checks, logging model
- **[DEVELOPMENT_GUIDE.md](./DEVELOPMENT_GUIDE.md)** — local engineering workflow and quality gates
- **[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)** — environment promotion and release runbook
- **[SECURITY.md](./SECURITY.md)** — threat model, secrets management, scanning
- **[CONTRIBUTING.md](./CONTRIBUTING.md)** — contribution process and standards
- **[CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)** — community behavior expectations
- **[ROADMAP.md](./ROADMAP.md)** — current priorities and planned evolution
- **[LICENSE](./LICENSE)** — open-source license terms

## Repository structure

```text
.
├── cart-cna-microservice/
├── products-cna-microservice/
├── search-cna-microservice/
├── users-cna-microservice/
├── store-ui/
├── k8s/
│   ├── helm/
│   ├── monitoring/
│   └── scripts/
├── docker-compose.yml
└── *.md documentation files
```

## Tech stack

- **Backend:** Node.js/Express, Spring Boot, FastAPI
- **Frontend:** React
- **Data:** MongoDB, PostgreSQL, Redis
- **Messaging:** RabbitMQ
- **Containers & Orchestration:** Docker, Docker Compose, Kubernetes, Helm
- **Observability:** Prometheus/Grafana (via `k8s/scripts/deploy-monitoring.sh`)

## Quick run

```bash
# 1) Start platform dependencies
docker-compose up -d

# 2) Start services (in separate terminals)
cd products-cna-microservice && npm install && npm start
cd cart-cna-microservice && gradle bootRun
cd users-cna-microservice && pipenv install && pipenv run python app.py
cd store-ui && npm install && npm start
```

For complete workflows (including Kubernetes and Terraform patterns), see [QUICK_START.md](./QUICK_START.md).

## Project quality notes

- This repo contains solid implementation assets, but some CI files are currently commented-out and should be enabled as part of hardening.
- Documentation has been organized to support portfolio review, onboarding, and production readiness conversations.

## License

Licensed under the MIT License. See [LICENSE](./LICENSE).
