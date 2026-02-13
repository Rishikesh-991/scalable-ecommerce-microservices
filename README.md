Scalable Microservices E-Commerce Platform
Table of Contents

Project Overview

Architecture

Features

Tech Stack

Repository Structure

Getting Started

Environment Variables

Running the Platform

Docker & Docker Compose

Kubernetes Deployment

Event-Driven Architecture

Payment Integration

Authentication & Security

Testing

CI/CD

Monitoring & Observability

Contributing

License

Contact

Project Overview

This repository contains a production-grade microservices e-commerce platform built with industry best practices for scalability, security, and observability.

Key goals:

Modular microservices architecture

Event-driven communication via RabbitMQ

Payment integration with Stripe

Secure authentication with JWT

Containerized deployment with Docker and Kubernetes

Ready for AWS EC2 or EKS deployment

Architecture

The system is composed of the following microservices:

Service	Tech	Port	Description
Products	Node.js/Express	5000	Manage products, deals, and inventory
Cart	Spring Boot	8080	Customer cart management
Users	FastAPI/Python	9090	User management (CRUD)
Search	Node.js/Proxy	4000	Search and Elasticsearch integration
Frontend	React	3000	Customer-facing web application
Auth (planned)	Spring Boot	8081	JWT-based authentication
Payments (planned)	Node.js/Express	8082	Stripe payment processing
Orders (planned)	Spring Boot	8083	Order lifecycle management

Databases & Message Broker:

MongoDB: Product data and deals

Redis: Cart caching

PostgreSQL: User data

RabbitMQ: Event-driven messaging

Features

Microservices architecture

Event-driven communication with RabbitMQ

Payment workflow (Stripe test integration)

JWT-based authentication (planned)

Input validation & rate limiting

Multi-database support: MongoDB, Redis, PostgreSQL

Dockerized and container-ready

Kubernetes deployment support

Full documentation & quick start guide

Tech Stack

Backend: Node.js, Express, Spring Boot, FastAPI
Frontend: React, Material-UI
Databases: MongoDB, PostgreSQL, Redis
Message Broker: RabbitMQ
Search Engine: Elasticsearch (optional)
Containerization: Docker, Docker Compose
Orchestration: Kubernetes (Helm charts)
Payment: Stripe API (Test Mode)
CI/CD: GitHub Actions
Monitoring: Prometheus & Grafana (planned)

Repository Structure
scalable-ecommerce-microservices/
├─ .github/                # CI/CD workflows
├─ cart-cna-microservice/  # Cart service
├─ products-cna-microservice/  # Products service
├─ search-cna-microservice/    # Search service
├─ users-cna-microservice/     # Users service
├─ store-ui/               # Frontend React app
├─ k8s/                    # Kubernetes manifests
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

Getting Started
Prerequisites

Docker >= 20.x

Docker Compose >= 2.x

Node.js >= 18.x

npm >= 9.x

Python >= 3.11

Java >= 17

Clone Repository
git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
cd scalable-ecommerce-microservices

Environment Variables

All sensitive keys and service ports are stored in .env.production.

Key Variables:

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


⚠️ Do not commit .env.production to public repos in production environments. Use secrets management (AWS Secrets Manager, Vault, etc.).

Running the Platform
Quick Start (15 minutes)

Start Databases and Services

docker-compose up -d
docker-compose ps  # Verify all services are healthy


Export Environment Variables

export $(cat .env.production | xargs)


Start Microservices
Open four terminals:

Terminal 1 – Products Service

cd products-cna-microservice
npm install
npm start


Terminal 2 – Cart Service

cd cart-cna-microservice
export SPRING_REDIS_HOST=localhost
gradle bootRun


Terminal 3 – Users Service

cd users-cna-microservice
pip install pipenv
pipenv install
pipenv shell
python app.py


Terminal 4 – Frontend

cd store-ui
npm install
npm start


Verify Services

curl http://localhost:5000/
curl http://localhost:8080/
curl http://localhost:9090/docs


Open Frontend

http://localhost:3000

Test Workflow

Browse products, add to cart, checkout (Stripe test cards)

Docker & Docker Compose

Start Everything

docker-compose up -d


Stop Everything

docker-compose down


View Logs

docker-compose logs -f <service_name>


Check Status

docker-compose ps

Kubernetes Deployment

All services containerized and ready for Helm deployment

Manifests located in k8s/ folder

Includes Deployments, Services, ConfigMaps, Secrets, and PersistentVolumes

See K8S_DEPLOYMENT_GUIDE.md for full instructions

Event-Driven Architecture

RabbitMQ as message broker

Standardized event format (JSON)

Topics:

order.*, payment.*, user.*, inventory.*

Consumers for notifications, analytics, inventory updates

Example Event

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

/payments/intent – create PaymentIntent

/payments/status/:id – check payment status

/payments/webhook – Stripe webhook

Test cards:

4242 4242 4242 4242 → success

4000 0000 0000 0002 → declined

4000 0000 0000 0069 → CVC error

Authentication & Security

JWT auth (planned)

Input validation across all services

Rate limiting per endpoint

HTTPS/TLS planned for production

Secrets managed via environment variables

Testing

Unit tests for all microservices

Integration tests for workflows

End-to-End (E2E) tests for checkout and cart

Test coverage target: 70%+

CI/CD

GitHub Actions workflows planned:

Build → Test → Security Scan → Deploy

Dockerized services ensure reproducible builds

Monitoring & Observability

Health checks per service: /health

Metrics endpoint: /metrics (Prometheus)

Centralized logging (planned ELK stack)

Tracing with distributed traceId

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

Email: rishikesh@example.com
