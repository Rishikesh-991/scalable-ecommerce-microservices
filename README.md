# 🛒 Scalable E-Commerce Microservices

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Container-blue?logo=docker)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestrator-blueviolet?logo=kubernetes)](https://kubernetes.io/)
[![Istio](https://img.shields.io/badge/Istio-Service%20Mesh-466BB0?logo=istio)](https://istio.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-orange?logo=terraform)](https://www.terraform.io/)
![GitHub last commit](https://img.shields.io/github/last-commit/Rishikesh-991/scalable-ecommerce-microservices)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/Rishikesh-991/scalable-ecommerce-microservices)

> **Production-grade e-commerce platform** built with polyglot microservices architecture (Node.js, Spring Boot, FastAPI, React), featuring Istio service mesh, Kubernetes orchestration, and comprehensive DevOps automation.

---

## 📑 **Table of Contents**

- [Project Overview](#-project-overview)
- [Why This Project](#-why-this-project)
- [Architecture](#-architecture)
- [Key Features](#-key-features)
- [Services](#-services)
- [Quick Start](#-quick-start)
- [API Reference](#-api-reference)
- [Deployment](#-deployment)
- [Monitoring](#-monitoring--observability)
- [Repository Structure](#-repository-structure)
- [Prerequisites](#-prerequisites)
- [Documentation](#-documentation)
- [License](#-license)

---

## 🌟 **Project Overview**

**Scalable E-Commerce Microservices** is a production-inspired distributed system designed to model real-world backend architecture patterns.

The platform decomposes core e-commerce domains — **catalog**, **cart**, **users**, and **search** — into independently deployable services, each with its own technology stack and data store.

### **Core Principles**

- ✅ **Service Isolation** - Database-per-service design pattern
- ✅ **Technology Flexibility** - Polyglot architecture (Node.js, Java, Python)
- ✅ **Asynchronous Communication** - Event-driven with RabbitMQ
- ✅ **Container-First** - Docker for local dev, Kubernetes for production
- ✅ **Infrastructure as Code** - Terraform + Helm for reproducibility
- ✅ **Observability** - Prometheus, Grafana, Istio telemetry

Rather than focusing only on CRUD functionality, this repository demonstrates **system design**, **operational readiness**, and **distributed systems fundamentals**.

---

## 💡 **Why This Project**

Modern backend systems are rarely monolithic. Production environments demand:

| Requirement | Traditional Monolith | This Project |
|-------------|---------------------|--------------|
| **Independent Scaling** | ❌ Scale entire app | ✅ Scale services individually |
| **Technology Choice** | ❌ Locked to one stack | ✅ Best tool per domain |
| **Fault Isolation** | ❌ One failure = downtime | ✅ Circuit breakers + retries |
| **Team Autonomy** | ❌ Shared codebase | ✅ Clear service boundaries |
| **Deployment Speed** | ❌ Risky big deployments | ✅ Canary + blue-green |
| **Observability** | ⚠️ Basic logging | ✅ Metrics, traces, dashboards |

### **What You'll Learn**

- 🎯 Designing microservices with clear bounded contexts
- 🔧 Operating distributed systems (service mesh, load balancing)
- 🚀 Building CI/CD pipelines for polyglot services
- 📊 Implementing production-grade monitoring
- 🔒 Securing inter-service communication (mTLS)
- ☸️ Deploying to Kubernetes with Helm
- 🏗️ Managing infrastructure with Terraform

This project serves as:

- ✅ **Portfolio showcase** of distributed system design
- ✅ **Learning platform** for cloud-native patterns
- ✅ **Foundation** for experimenting with scalability/resilience
- ✅ **Interview preparation** for backend/DevOps roles

---

## 🏗️ **Architecture**

### **High-Level System Design**

┌─────────────────────────────────────────────────────────────────┐
│ ISTIO SERVICE MESH │
│ (mTLS, Traffic Management, Observability) │
└─────────────────────────────────────────────────────────────────┘
│
┌───────────────┴───────────────┐
│ │
┌───────▼────────┐ ┌───────▼────────┐
│ Frontend │ │ Istio Gateway │
│ (React/TS) │ │ (Port 80/443) │
│ Port 3000 │ └────────┬────────┘
└─────────────────┘ │
┌──────────────┼──────────────┐
│ │ │
┌───────────▼─────┐ ┌────▼─────┐ ┌────▼─────┐
│ Products (5000)│ │Users(9090│ │Cart (8080│
│ Node.js/Express│ │FastAPI) │ │SpringBoot│
│ MongoDB │ │PostgreSQL│ │ Redis │
└─────────────────┘ └──────────┘ └──────────┘
│
┌───────────▼─────┐
│ Search (4000) │
│ Node.js/Express│
│ Elasticsearch │
└─────────────────┘



### **Service Mesh Benefits**

```
┌─────────────────────────────────────────────────────────────────┐
│                      ISTIO SERVICE MESH                          │
│          (mTLS, Traffic Management, Observability)               │
└─────────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              │                               │
      ┌───────▼────────┐             ┌───────▼────────┐
      │   Frontend      │             │  Istio Gateway  │
      │  (React/TS)     │             │   (Port 80/443) │
      │   Port 3000     │             └────────┬────────┘
      └─────────────────┘                      │
                                ┌──────────────┼──────────────┐
                                │              │              │
                    ┌───────────▼─────┐  ┌────▼─────┐  ┌────▼─────┐
                    │  Products (5000)│  │Users(9090│  │Cart (8080│
                    │  Node.js/Express│  │FastAPI)  │  │SpringBoot│
                    │    MongoDB      │  │PostgreSQL│  │  Redis   │
                    └─────────────────┘  └──────────┘  └──────────┘
                                │
                    ┌───────────▼─────┐
                    │  Search (4000)  │
                    │  Node.js/Express│
                    │  Elasticsearch  │
                    └─────────────────┘
```

**📚 Detailed Architecture**: [Architecture Overview](./docs/architecture/overview.md) | [Diagrams](./docs/architecture/diagrams.md)

---

## ✨ **Key Features**

### **Business Features**

| Feature | Status | Description |
|---------|--------|-------------|
| 👤 User Management | ✅ | Registration, authentication (JWT), profile management |
| 📦 Product Catalog | ✅ | CRUD operations, categories, deals, inventory tracking |
| 🛒 Shopping Cart | ✅ | Session-based cart with Redis, add/update/remove items |
| 🔍 Search | ✅ | Full-text product search with Elasticsearch |
| 📦 Order Management | 🚧 | Order processing pipeline (Q2 2024) |
| 💳 Payment Gateway | 📋 | Stripe/PayPal integration (planned) |

### **Technical Features**

| Category | Features |
|----------|----------|
| **Architecture** | Polyglot microservices • Database-per-service • Event-driven (RabbitMQ) |
| **Service Mesh** | Istio mTLS • Traffic management • Circuit breakers • Retries |
| **Containerization** | Docker multi-stage builds • Non-root containers • Health checks |
| **Orchestration** | Kubernetes 1.28+ • Helm charts • HPA autoscaling |
| **CI/CD** | GitHub Actions • Automated tests • Docker image scanning • K8s deployment |
| **Observability** | Prometheus metrics • Grafana dashboards • Distributed tracing (planned) |
| **Security** | mTLS encryption • RBAC • Network policies • Secret management |
| **IaC** | Terraform modules (AWS/GCP) • Helm values per environment |

**Legend:** ✅ Implemented | 🚧 In Progress | 📋 Planned

---

## 🔧 **Services**

| Service | Stack | Port | Database | Responsibilities |
|---------|-------|------|----------|-----------------|
| **Products** | Node.js 18 + Express | 5000 | MongoDB | Product catalog, deals, inventory management |
| **Cart** | Java 17 + Spring Boot | 8080 | Redis | Cart operations, session management, pricing |
| **Users** | Python 3.12 + FastAPI | 9090 | PostgreSQL | User registration, authentication, profiles |
| **Search** | Node.js 18 + Express | 4000 | Elasticsearch | Full-text product search, filtering |
| **Frontend** | React 18 + TypeScript | 3000 | N/A | Customer-facing storefront UI |

### **Infrastructure Services**

| Service | Technology | Purpose |
|---------|-----------|---------|
| **Service Mesh** | Istio 1.20+ | Traffic management, mTLS, observability |
| **Monitoring** | Prometheus + Grafana | Metrics collection, visualization |
| **Message Queue** | RabbitMQ 3.12 | Async event processing |
| **API Gateway** | Istio Gateway | External traffic routing, TLS termination |

---

## 🚀 **Quick Start** (5 Minutes)

### **Option A: Docker Compose** (Recommended)

```bash
# 1. Clone repository
git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
cd scalable-ecommerce-microservices

# 2. Create environment file
cp .env.production .env

# 3. Start all services
docker-compose up -d

# 4. Verify services
./DATABASE_VERIFICATION.sh
docker-compose ps

# 5. Access application
echo "Frontend:    http://localhost:3000"
echo "Products:    http://localhost:5000/health"
echo "Cart:        http://localhost:8080/actuator/health"
echo "Users:       http://localhost:9090/health"
echo "Search:      http://localhost:4000/health"
echo "Grafana:     http://localhost:3030 (admin/admin)"
echo "Prometheus:  http://localhost:9090"
```

### **Option B: Kubernetes with Kind (Local K8s)
```cd k8s/scripts

# 1. Create local Kubernetes cluster
./setup-kind-cluster.sh

# 2. Install Istio service mesh
./install-istio.sh

# 3. Deploy all services
./deploy-dev.sh

# 4. Port forward to access services
kubectl port-forward svc/frontend 3000:80 -n ecommerce
kubectl port-forward svc/istio-ingressgateway 8080:80 -n istio-system

# Open: http://localhost:3000
```
##Troubleshooting Quick Start
### Find and kill process
```lsof -i :5000
kill -9 <PID>

# Or change port in docker-compose.yml

# Check containers
docker-compose ps

# View logs
docker-compose logs postgres mongodb redis

# Reset (⚠️ data loss)
docker-compose down -v
docker-compose up -d

# Check logs
docker-compose logs -f <service-name>

# Restart specific service
docker-compose restart <service-name>

# Full rebuild
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```


## 1. Provision infrastructure (Terraform)
```
cd terraform/aws
terraform init
terraform plan
terraform apply
```

## 2. Configure kubectl

```
aws eks update-kubeconfig --name ecommerce-cluster --region us-east-1

```
## 3. Install Istio
```
./k8s/scripts/install-istio.sh

```
## 4. Deploy services
```cd k8s/scripts
./deploy-prod.sh
```
## 5. Verify deployment
```kubectl get all -n ecommerce
kubectl get gateway,virtualservice -n ecommerce
```

 # Repository Structure
 ```
  .
├── 📂 cart-cna-microservice/          # Spring Boot cart service
│   ├── src/main/java/                 # Java source code
│   ├── Dockerfile                     # Multi-stage Docker build
│   ├── build.gradle                   # Gradle build config
│   └── CartAPI.postman_collection.json # API tests
├── 📂 products-cna-microservice/      # Node.js products service
│   ├── routes/                        # Express routes
│   ├── db/                            # MongoDB connection
│   ├── data/                          # Seed data (products, deals)
│   └── Dockerfile
├── 📂 users-cna-microservice/         # FastAPI users service
│   ├── routers/                       # FastAPI routers
│   ├── db/                            # PostgreSQL DAL
│   └── Dockerfile
├── 📂 search-cna-microservice/        # Node.js search service
│   └── Dockerfile
├── 📂 store-ui/                       # React frontend
│   ├── src/
│   │   ├── components/                # Reusable React components
│   │   ├── pages/                     # Page components
│   │   └── api/                       # API client layer
│   ├── nginx.conf                     # Production Nginx config
│   └── Dockerfile
├── 📂 k8s/                            # Kubernetes manifests
│   ├── helm/                          # Helm charts per service
│   │   ├── ecommerce-cart/
│   │   ├── ecommerce-products/
│   │   ├── ecommerce-users/
│   │   ├── ecommerce-search/
│   │   └── ecommerce-frontend/
│   ├── istio/                         # Istio service mesh configs
│   │   ├── gateway.yaml               # External traffic entry
│   │   ├── virtual-services.yaml     # Routing rules
│   │   ├── destination-rules.yaml    # Load balancing, circuit breakers
│   │   └── mtls-policy.yaml          # Mutual TLS enforcement
│   ├── monitoring/                    # Prometheus/Grafana
│   │   └── grafana/dashboards/
│   ├── scripts/                       # Deployment automation
│   │   ├── setup-kind-cluster.sh
│   │   ├── install-istio.sh
│   │   ├── deploy-dev.sh
│   │   └── deploy-prod.sh
│   ├── values-dev.yaml                # Development configuration
│   └── values-prod.yaml               # Production configuration
├── 📂 docs/                           # Documentation
│   ├── architecture/
│   │   ├── overview.md
│   │   └── diagrams.md
│   ├── deployment/
│   │   ├── quick-start.md
│   │   ├── docker.md
│   │   ├── kubernetes.md
│   │   └── terraform.md
│   ├── operations/
│   │   ├── development-guide.md
│   │   ├── deployment-guide.md
│   │   └── monitoring.md
│   ├── security/
│   │   └── security.md
│   └── project/
│       ├── contributing.md
│       ├── code-of-conduct.md
│       └── roadmap.md
├── 📂 .github/workflows/              # CI/CD pipelines
│   ├── ci-cd.yml                      # Main pipeline
│   └── node.js.yml                    # Node.js tests
├── 🐳 docker-compose.yml              # Local development environment
├── 📄 .env.production                 # Environment variables template
├── 📜 DATABASE_VERIFICATION.sh        # Database health check script
└── 📖 README.md                       # You are here

```


## 📋 **Prerequisites**

### **For Local Development**

| Tool | Version | Install Link |
|------|---------|--------------|
| Docker | 24+ | [Install](https://docs.docker.com/get-docker/) |
| Docker Compose | 2.20+ | [Install](https://docs.docker.com/compose/install/) |
| Node.js | 18+ | [Install](https://nodejs.org/) |
| Python | 3.12+ | [Install](https://www.python.org/downloads/) |
| Java JDK | 17+ | [Install](https://adoptium.net/) |
| Git | Latest | [Install](https://git-scm.com/downloads) |

### **For Kubernetes Deployment**

| Tool | Version | Install Link |
|------|---------|--------------|
| kubectl | 1.28+ | [Install](https://kubernetes.io/docs/tasks/tools/) |
| Helm | 3.12+ | [Install](https://helm.sh/docs/intro/install/) |
| Istioctl | 1.20+ | [Install](https://istio.io/latest/docs/setup/getting-started/) |
| Kind | Latest | [Install](https://kind.sigs.k8s.io/docs/user/quick-start/) |

### **For Production**

- Kubernetes cluster (AWS EKS, GCP GKE, Azure AKS)
- Container registry (Docker Hub, AWS ECR, GCP GCR)
- DNS domain for external access
- TLS certificates (Let's Encrypt recommended)

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

For full workflows, see the [Quick Start guide](./docs/deployment/quick-start.md).
# Production deployment uses:
- Kubernetes: Container orchestration
- Helm: Package management
- Istio: Service mesh (traffic, security, observability)
- Prometheus: Metrics collection
- Grafana: Visualization
- HPA: Auto-scaling based on CPU/memory


---

## 🌐 **Deployment**

### **Deployment Options Comparison**

| Feature | Docker Compose | Kubernetes (Kind) | Production K8s |
|---------|---------------|-------------------|----------------|
| **Use Case** | Local dev | Local testing | Production |
| **Setup Time** | 5 min | 15 min | 1-2 hours |
| **Resources** | 8GB RAM | 16GB RAM | Cloud resources |
| **Scaling** | Manual | HPA | HPA + Cluster Autoscaler |
| **Service Mesh** | ❌ | ✅ Istio | ✅ Istio |
| **Load Balancing** | Docker network | Istio Gateway | Cloud LB + Istio |
| **Monitoring** | ✅ Prometheus/Grafana | ✅ Full stack | ✅ Full stack |
| **Cost** | Free | Free | ~$200-500/month |

---

---

## 📊 **Monitoring & Observability**

### **Grafana Dashboards**

Access: `http://localhost:3030` (admin/admin)

**Pre-configured Dashboards:**
- **E-Commerce Overview**: Request rates, error rates, latency (P50/P95/P99)
- **Infrastructure**: CPU, memory, disk, network per service
- **Istio Service Mesh**: Traffic flow, mTLS status, circuit breaker metrics
- **Database Health**: Connection pools, query performance

### **Prometheus Metrics**

```bash
# Port forward Prometheus
kubectl port-forward svc/prometheus 9090:9090 -n ecommerce

# Access: http://localhost:9090

```
## License

Licensed under the MIT License. See [LICENSE](./LICENSE).
## Author

Created and maintained by **Rishikesh (Rishikesh-991)**  
GitHub: https://github.com/Rishikesh-991

### **Connect**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://linkedin.com/in/your-profile)
[![Twitter](https://img.shields.io/badge/Twitter-Follow-blue?logo=twitter)](https://twitter.com/your-handle)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/Rishikesh-991)



