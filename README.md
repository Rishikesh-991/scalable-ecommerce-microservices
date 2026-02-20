# Scalable E-Commerce Microservices
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Container-blue)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestrator-blueviolet)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-orange)](https://www.terraform.io/)



Production-style e-commerce platform using a polyglot microservices architecture (Node.js, Spring Boot, FastAPI, React), with Docker-first local setup and Kubernetes/Terraform deployment assets.

## 🧠 Project Overview

This repository demonstrates real-world DevOps engineering patterns by building a distributed microservices platform that:

- Runs in containers (Docker)
- Deploys on Kubernetes (Helm charts)
- Manages infrastructure with Terraform
- Uses asynchronous messaging (RabbitMQ)
- Implements observability (Prometheus + Grafana)
- Separates concerns into independent services

Rather than being a simple CRUD project, it focuses on *DevOps‑relevant workflows*, deployment patterns, and automation best practices.

---
## Why This Project

DevOps environments demand:

- Declarative infrastructure provisioning  
- Immutable, containerized application artifacts  
- Zero‑touch deployments and CI/CD  
- Monitoring and alerting of distributed components  
- Resilience and fault‑tolerant systems  
- Decoupled operations across teams

This project demonstrates:

- Docker + Kubernetes orchestration
- Terraform for cloud infrastructure
- Automated deployment strategies
- Monitoring integration
- Multi‑service observability
- Environment configuration and secrets management

---
## ⚙️ DevOps Oriented Technology Stack

| Layer | Tools |
|-------|-------|
| Containerization | Docker |
| Orchestration | Kubernetes + Helm |
| Infrastructure as Code | Terraform |
| Messaging | RabbitMQ |
| Observability | Prometheus, Grafana |
| Logging | Standard out / sidecar patterns |
| Local Dev Orchestration | Docker Compose |

---

## 🧩 Key DevOps Focus Areas

- **Dockerized services** with multi‑stage builds
- **Kubernetes manifests + Helm charts**
- **Terraform IaC for environment provisioning**
- **Centralized monitoring (Prometheus + Grafana)**
- **Service health checks and readiness probes**
- **Environment configuration management**
- **Documentation aligned with industry standards**

---

## Implemented services

| Service | Stack | Default Port | Primary responsibility |
|---|---|---:|---|
| `products-cna-microservice` | Node.js + Express | 5000 | Product catalog and deals APIs (MongoDB-backed) |
| `cart-cna-microservice` | Spring Boot | 8080 | Cart operations and pricing flow (Redis-backed) |
| `users-cna-microservice` | FastAPI | 9090 | User lifecycle APIs (PostgreSQL-backed) |
| `search-cna-microservice` | Node.js | 4000 | Search integration service (Elasticsearch-oriented) |
| `store-ui` | React | 3000 | Storefront UI consuming backend APIs |


## Flow & Diagrams

- [High-level architecture diagram](./docs/architecture/diagrams.md#1-high-level-architecture-diagram)
- [Service-to-service communication](./docs/architecture/diagrams.md#2-service-to-service-communication-diagram)
- [Event Flow / RabbitMQ](./docs/architecture/diagrams.md#3-event-flow-diagram-rabbitmq--async-messaging)
- [Request Lifecycle Flowchart](./docs/architecture/diagrams.md#4-request-lifecycle-flowchart)
---


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
## Author

Created and maintained by **Rishikesh (Rishikesh-991)**  
GitHub: https://github.com/Rishikesh-991
