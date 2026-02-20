# Scalable E-Commerce Microservices

Production-style e-commerce platform using a polyglot microservices architecture (Node.js, Spring Boot, FastAPI, React), with Docker-first local setup and Kubernetes/Terraform deployment assets.

## Implemented services

| Service | Stack | Default Port | Primary responsibility |
|---|---|---:|---|
| `products-cna-microservice` | Node.js + Express | 5000 | Product catalog and deals APIs (MongoDB-backed) |
| `cart-cna-microservice` | Spring Boot | 8080 | Cart operations and pricing flow (Redis-backed) |
| `users-cna-microservice` | FastAPI | 9090 | User lifecycle APIs (PostgreSQL-backed) |
| `search-cna-microservice` | Node.js | 4000 | Search integration service (Elasticsearch-oriented) |
| `store-ui` | React | 3000 | Storefront UI consuming backend APIs |

## Documentation

All repository-level docs now live under [`/docs`](./docs/README.md) and are grouped by category:

- **Architecture**
  - [Overview](./docs/architecture/overview.md)
  - [Diagrams](./docs/architecture/diagrams.md)
    - High-level architecture
    - Service-to-service communication
    - RabbitMQ / async event flow
    - Request lifecycle flowchart
- **Deployment**
  - [Quick Start](./docs/deployment/quick-start.md)
  - [Docker](./docs/deployment/docker.md)
  - [Kubernetes](./docs/deployment/kubernetes.md)
  - [Terraform](./docs/deployment/terraform.md)
- **Operations**
  - [Development Guide](./docs/operations/development-guide.md)
  - [Deployment Runbook](./docs/operations/deployment-guide.md)
  - [Monitoring](./docs/operations/monitoring.md)
- **Security**
  - [Security Guide](./docs/security/security.md)
- **Project governance**
  - [Contributing](./docs/project/contributing.md)
  - [Code of Conduct](./docs/project/code-of-conduct.md)
  - [Roadmap](./docs/project/roadmap.md)

## Repository structure

```text
.
├── cart-cna-microservice/
├── products-cna-microservice/
├── search-cna-microservice/
├── users-cna-microservice/
├── store-ui/
├── docs/
│   ├── architecture/
│   ├── deployment/
│   ├── operations/
│   ├── project/
│   └── security/
├── k8s/
└── docker-compose.yml
```

## Quick run

```bash
# Start shared dependencies
docker-compose up -d

# Run services (separate terminals)
cd products-cna-microservice && npm install && npm start
cd cart-cna-microservice && gradle bootRun
cd users-cna-microservice && pipenv install && pipenv run python app.py
cd store-ui && npm install && npm start
```

For full workflows, see the [Quick Start guide](./docs/deployment/quick-start.md).

## License

Licensed under the MIT License. See [LICENSE](./LICENSE).
