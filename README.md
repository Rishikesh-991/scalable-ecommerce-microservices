# Scalable E-Commerce Microservices
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Container-blue)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestrator-blueviolet)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-orange)](https://www.terraform.io/)



Production-style e-commerce platform using a polyglot microservices architecture (Node.js, Spring Boot, FastAPI, React), with Docker-first local setup and Kubernetes/Terraform deployment assets.

## Project Overview

Scalable E-Commerce Microservices is a production-inspired distributed system designed to model real-world backend architecture patterns.  

The platform decomposes core e-commerce domains — catalog, cart, users, and search — into independently deployable services, each with its own technology stack and data store.

The project emphasizes:

- Service isolation and database-per-service design  
- Asynchronous communication using RabbitMQ  
- Polyglot backend architecture  
- Containerized local development  
- Kubernetes-ready deployment  
- Infrastructure-as-Code patterns with Terraform  

Rather than focusing only on CRUD functionality, this repository demonstrates system design, operational readiness, and distributed systems fundamentals.

## Why This Project

Modern backend systems are rarely monolithic. Production environments demand:

- Independent service scaling  
- Technology flexibility per domain  
- Fault isolation  
- Clear service boundaries  
- Infrastructure automation  
- Observability and monitoring  

This project was built to simulate those real-world concerns in a controlled environment.

It serves as:

- A practical exploration of microservices architecture  
- A demonstration of DevOps-oriented engineering practices  
- A portfolio-ready showcase of distributed system design  
- A foundation for experimenting with scalability, resilience, and event-driven patterns  

The goal is not just to build an application — but to model how modern systems are structured and operated.


## Key Features

- Polyglot microservices (Node.js, Spring Boot, FastAPI)  
- Database-per-service design (MongoDB, PostgreSQL, Redis)  
- Event-driven architecture with RabbitMQ  
- Dockerized local development  
- Kubernetes & Helm deployment support  
- Infrastructure-as-Code with Terraform  
- Structured production-grade documentation  


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
