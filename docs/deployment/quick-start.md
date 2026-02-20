# Quick Start

This guide gives fast, practical paths to run the platform in four modes:
1. Local development
2. Docker Compose
3. Kubernetes (Helm)
4. Terraform-driven infrastructure workflow

---

## 1. Prerequisites

Install the following tools:

- Git
- Docker >= 20.x and Docker Compose >= 2.x
- Node.js >= 18.x
- Java 17+ and Gradle
- Python 3.11+ and Pipenv
- Kubernetes CLI tooling (for K8s path): `kubectl`, `helm`
- Terraform >= 1.5 (for IaC path)

Verify installation:

```bash
git --version
docker --version
docker compose version
node --version
java --version
python --version
kubectl version --client
helm version
terraform version
```

---

## 2. Clone and initialize

```bash
git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
cd scalable-ecommerce-microservices
```

Create local environment variables (never commit real secrets):

```bash
cp .env.production .env.local 2>/dev/null || true
```

---

## 3. Local development (service-by-service)

### 3.1 Start platform dependencies

```bash
docker-compose up -d
```

### 3.2 Start application services

Open separate terminals:

```bash
# Products API
cd products-cna-microservice
npm install
npm start
```

```bash
# Cart API
cd cart-cna-microservice
gradle bootRun
```

```bash
# Users API
cd users-cna-microservice
pipenv install
pipenv run python app.py
```

```bash
# Frontend
cd store-ui
npm install
npm start
```

### 3.3 Verify

```bash
curl -i http://localhost:5000/
curl -i http://localhost:8080/
curl -i http://localhost:9090/docs
```

UI: <http://localhost:3000>

---

## 4. Docker Compose path

Use this when you want repeatable local runtime and dependency bootstrapping.

```bash
# Start
docker-compose up -d

# Inspect
docker-compose ps
docker-compose logs -f

# Stop
docker-compose down
```

See [DOCKER.md](./docker.md) for build optimization and multi-stage guidance.

---

## 5. Kubernetes path (Helm)

### 5.1 Create a local Kind cluster (optional)

```bash
bash k8s/scripts/setup-kind-cluster.sh
```

### 5.2 Deploy development profile

```bash
bash k8s/scripts/deploy-dev.sh
```

### 5.3 Check workload health

```bash
kubectl get ns
kubectl get pods -A
kubectl get svc -A
```

See [KUBERNETES.md](./kubernetes.md) for deployment strategies and chart structure.

---

## 6. Terraform path (infrastructure workflow)

> The repo currently documents a recommended Terraform structure and workflow. If your team adds Terraform code, follow this process.

```bash
cd infra/environments/dev
terraform init
terraform fmt -check
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

See [TERRAFORM.md](./terraform.md) for module, remote state, and promotion strategy.

---

## 7. Next steps

- Engineering workflow: [DEVELOPMENT_GUIDE.md](../operations/development-guide.md)
- Deployment and promotion: [DEPLOYMENT_GUIDE.md](../operations/deployment-guide.md)
- Security controls: [SECURITY.md](../security/security.md)
- Monitoring and SLO practices: [MONITORING.md](../operations/monitoring.md)
