# Scalable Microservices E-Commerce Platform

## Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Environment Variables](#environment-variables)
- [Running the Platform](#running-the-platform)
- [Docker & Docker Compose](#docker--docker-compose)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Event-Driven Architecture](#event-driven-architecture)
- [Payment Integration](#payment-integration)
- [Authentication & Security](#authentication--security)
- [Testing](#testing)
- [CI/CD](#cicd)
- [Monitoring & Observability](#monitoring--observability)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Project Overview

This repository contains a production-grade microservices e-commerce platform built with industry best practices for scalability, security, and observability.

**Key Goals:**

- Modular microservices architecture
- Event-driven communication via RabbitMQ
- Payment integration with Stripe
- Secure authentication with JWT
- Containerized deployment with Docker and Kubernetes
- Ready for AWS EC2 or EKS deployment

---

## Architecture

The system is composed of the following microservices:

| Service | Tech | Port | Description |
|---------|------|------|-------------|
| Products | Node.js/Express | 5000 | Manage products, deals, and inventory |
| Cart | Spring Boot | 8080 | Customer cart management |
| Users | FastAPI/Python | 9090 | User management (CRUD) |
| Search | Node.js/Proxy | 4000 | Search and Elasticsearch integration |
| Frontend | React | 3000 | Customer-facing web application |
| Auth (planned) | Spring Boot | 8081 | JWT-based authentication |
| Payments (planned) | Node.js/Express | 8082 | Stripe payment processing |
| Orders (planned) | Spring Boot | 8083 | Order lifecycle management |

**Databases & Message Broker:**

- MongoDB: Product data and deals
- Redis: Cart caching
- PostgreSQL: User data
- RabbitMQ: Event-driven messaging

---

## Features

- Microservices architecture
- Event-driven communication with RabbitMQ
- Payment workflow (Stripe test integration)
- JWT-based authentication (planned)
- Input validation & rate limiting
- Multi-database support: MongoDB, Redis, PostgreSQL
- Dockerized and container-ready
- Kubernetes deployment support
- Full documentation & quick start guide

---

## Tech Stack

- **Backend:** Node.js, Express, Spring Boot, FastAPI  
- **Frontend:** React, Material-UI  
- **Databases:** MongoDB, PostgreSQL, Redis  
- **Message Broker:** RabbitMQ  
- **Search Engine:** Elasticsearch (optional)  
- **Containerization:** Docker, Docker Compose  
- **Orchestration:** Kubernetes (Helm charts)  
- **Payment:** Stripe API (Test Mode)  
- **CI/CD:** GitHub Actions  
- **Monitoring:** Prometheus & Grafana (planned)  

---

## Repository Structure
scalable-ecommerce-microservices/
├─ .github/
├─ cart-cna-microservice/
├─ products-cna-microservice/
├─ search-cna-microservice/
├─ users-cna-microservice/
├─ store-ui/
├─ k8s/
├─ .dockerignore
├─ .gitignore
├─ .env.production
├─ docker-compose.yml
├─ FINAL_SUMMARY.txt
├─ IMPLEMENTATION_GUIDE.md
├─ IMPLEMENTATION_COMPLETE.md
├─ QUICK_START.md
├─ CHANGES_SUMMARY.md
├─ README_UPDATES.md
└─ DATABASE_VERIFICATION.sh

---

## Getting Started

### Prerequisites

- Docker >= 20.x  
- Docker Compose >= 2.x  
- Node.js >= 18.x  
- npm >= 9.x  
- Python >= 3.11  
- Java >= 17  

### Clone Repository

```bash
git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
cd scalable-ecommerce-microservices

Environment Variables

All sensitive keys and ports are in .env.production:

# Database
MONGO_URI=mongodb://admin:admin123@localhost:27017/ecommerce
POSTGRES_URI=postgresql://admin:admin123@localhost:5432/ecommerce
REDIS_URL=redis://:redis123@localhost:6379

# RabbitMQ
RABBITMQ_URL=amqp://admin:admin123@localhost:5672

# JWT
JWT_SECRET=your_jwt_secret_here
JWT_EXPIRATION=86400

# Stripe
STRIPE_PUBLIC_KEY=pk_test_ABCDEFGHIJKLMNOPQRST
STRIPE_SECRET_KEY=sk_test_51234567890abcdefghijklmn
STRIPE_WEBHOOK_SECRET=whsec_test_abcdefghijklmnopqrstuvwxyz

# Ports
PRODUCTS_PORT=5000
CART_PORT=8080
USERS_PORT=9090
FRONTEND_PORT=3000



⚠️ Do not commit .env.production to public repos in production environments. Use secrets management.

Running the Platform
Quick Start (15 min)
# Start databases & services
docker-compose up -d
docker-compose ps

# Export environment variables
export $(cat .env.production | xargs)

Start Microservices

Terminal 1 – Products:

cd products-cna-microservice
npm install
npm start


Terminal 2 – Cart:

cd cart-cna-microservice
export SPRING_REDIS_HOST=localhost
gradle bootRun


Terminal 3 – Users:

cd users-cna-microservice
pip install pipenv
pipenv install
pipenv shell
python app.py


Terminal 4 – Frontend:

cd store-ui
npm install
npm start

Verify Services
curl http://localhost:5000/
curl http://localhost:8080/
curl http://localhost:9090/docs


Open frontend: http://localhost:3000

Docker & Docker Compose
# Start everything
docker-compose up -d

# Stop everything
docker-compose down

# View logs
docker-compose logs -f <service_name>

# Check status
docker-compose ps

Kubernetes Deployment

Services are containerized and ready for Helm deployment

Manifests are in k8s/

Includes Deployments, Services, ConfigMaps, Secrets, PersistentVolumes

See K8S_DEPLOYMENT_GUIDE.md for full instructions

Event-Driven Architecture

RabbitMQ as message broker

Standardized event format (JSON)

Topics: order.*, payment.*, user.*, inventory.*

Consumers for notifications, analytics, inventory updates

Example Event:

{
  "eventId": "evt_12345",
  "eventType": "order.created",
  "timestamp": "2026-02-13T10:30:00Z",
  "source": "order-service",
  "data": { "orderId": "ORD-2026-001", "customerId": "cust123" },
  "metadata": { "correlationId": "corr123", "userId": "user123" }
}

Payment Integration

Stripe test mode configured

Endpoints (planned):

/payments/intent

/payments/status/:id

/payments/webhook

Test cards:

4242 4242 4242 4242 → success

4000 0000 0000 0002 → declined

4000 0000 0000 0069 → CVC error

Authentication & Security

JWT auth (planned)

Input validation and rate limiting

HTTPS/TLS planned for production

Secrets via environment variables

Testing

Unit tests for all services

Integration tests for workflows

End-to-End tests for checkout & cart

Coverage target: 70%+

CI/CD

GitHub Actions workflows planned: Build → Test → Security Scan → Deploy

Dockerized services for reproducible builds

Monitoring & Observability

Health checks: /health

Metrics endpoint: /metrics (Prometheus)

Centralized logging (planned ELK stack)

Distributed tracing with traceId

Contributing

Fork repository

Create feature branch (git checkout -b feature-name)

Commit changes (git commit -m "Description")

Push branch (git push origin feature-name)

Open Pull Request

Code Standards:

Node.js → ESLint + Prettier

Java → Checkstyle

Python → PEP8 + Black

License

MIT License © 2026 Rishikesh-991

Contact

Repository: https://github.com/Rishikesh-991/scalable-ecommerce-microservices

Email: rishikeshkourav991@gmail.com
