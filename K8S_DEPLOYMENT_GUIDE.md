# Kubernetes Deployment Guide

Complete guide for deploying ecommerce microservices to Kubernetes using Kind (locally) and production environments.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Local Development Setup (Kind)](#local-development-setup-kind)
3. [Istio Service Mesh](#istio-service-mesh)
4. [Helm Chart Structure](#helm-chart-structure)
5. [Production Deployment](#production-deployment)
6. [Monitoring and Observability](#monitoring-and-observability)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Tools
```bash
# Install Kind (Kubernetes in Docker)
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/

# Install kubectl
curl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Istio (istioctl)
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.18.0
export PATH=$PWD/bin:$PATH
```

### System Requirements
- Docker (running)
- 8GB+ available memory
- 20GB+ disk space
- Linux/macOS (WSL on Windows)

## Local Development Setup (Kind)

### Step 1: Create Kind Cluster

```bash
cd k8s/scripts
./setup-kind-cluster.sh
```

This will:
- Create a multi-node K8s cluster
- Configure local storage for persistent volumes
- Set up proper networking for Istio ingress

**Verify cluster:**
```bash
kubectl get nodes
kubectl get namespaces
```

### Step 2: Install Istio

```bash
cd k8s/scripts
./install-istio.sh
```

This will:
- Install Istio control plane (pilot, proxy, etc.)
- Enable sidecar injection for ecommerce namespace
- Configure ingress gateway

**Verify Istio:**
```bash
kubectl get pods -n istio-system
kubectl get svc -n istio-system
```

### Step 3: Deploy Application (Dev Environment)

```bash
cd k8s/scripts

# Add Bitnami Helm repo
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Deploy everything
./deploy-dev.sh
```

**Verify deployment:**
```bash
kubectl get all -n ecommerce
kubectl get persistentvolumes
kubectl get virtualservices -n ecommerce
```

### Step 4: Access Application Locally

```bash
# Port forward Istio ingress gateway
kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80 8443:443

# In another terminal:
# Frontend
curl http://localhost:8080

# Products API
curl http://products.localhost:8080/health

# Users API
curl http://users.localhost:8080/docs

# Kiali Dashboard
istioctl dashboard kiali
# Access at http://localhost:20001

# Prometheus
istioctl dashboard prometheus

# Jaeger Tracing
istioctl dashboard jaeger
```

### Step 5: Add Hosts Entry (Optional)

For browser access without port-forwarding:
```bash
# Edit /etc/hosts (or C:\Windows\System32\drivers\etc\hosts on Windows)
127.0.0.1 localhost products.localhost search.localhost users.localhost
```

## Istio Service Mesh

### Architecture

```
┌─────────────────────────────────────────────────────────┐
│ Istio Service Mesh                                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌─────────────┐                                       │
│  │  Ingress    │                                       │
│  │  Gateway    │──┐                                    │
│  └─────────────┘  │                                    │
│                   │   ┌──────────────────────┐        │
│                   ├──>│ Virtual Service      │        │
│                   │   │ (Routing Rules)      │        │
│                   │   └──────────────────────┘        │
│                   │                │                  │
│                   │      ┌─────────┴──────────┐      │
│                   │      │                    │      │
│         ┌─────────┴──────►├──────────────────┤      │
│         │                 │ Destination Rule │      │
│         │                 │ (Load Balancing) │      │
│         │                 └──────────────────┘      │
│    ┌────┴────┐  ┌───────┐  ┌───────┐  ┌───────┐   │
│    │ Frontend│  │Product│  │ Users │  │ Search│   │
│    │(Pod 1)  │  │(Pod 1)│  │(Pod 1)│  │(Pod 1)│   │
│    └──────┬──┘  └───┬───┘  └───┬───┘  └───────┘   │
│           │        │          │                    │
│    ┌──────┴────────┴──────────┴──┐               │
│    │  Envoy Sidecars (mTLS)      │               │
│    │  - Circuit Breaker          │               │
│    │  - Retries                  │               │
│    │  - Timeouts                 │               │
│    └─────────────────────────────┘               │
│                                                 │
└─────────────────────────────────────────────────┘
```

### Key Features

#### 1. Traffic Management
- **VirtualService**: Define routing rules, retries, timeouts
- **DestinationRule**: Load balancing policies, connection pools
- **Gateway**: Ingress entry point for external traffic

#### 2. Security (mTLS)
- **PeerAuthentication**: Enforce mTLS between services
- **AuthorizationPolicy**: Fine-grained access control
- **ServiceEntry**: Define external services

#### 3. Observability
- **Kiali**: Service mesh visualization
- **Prometheus**: Metrics collection
- **Jaeger**: Distributed tracing
- **Grafana**: Dashboards

## Helm Chart Structure

### Chart Organization

```
k8s/helm/
├── ecommerce-frontend/          # React UI
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── configmap.yaml
├── ecommerce-products/          # Products microservice
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── configmap.yaml
│       ├── secrets.yaml
│       └── _helpers.tpl
├── ecommerce-users/             # Users microservice
├── ecommerce-search/            # Search service
├── ecommerce-cart/              # Cart service
├── ecommerce-postgres/          # PostgreSQL database
├── ecommerce-mongodb/           # MongoDB database
└── ecommerce-redis/             # Redis cache
```

### Values Hierarchy

```
Default Values (Chart.yaml)
         ↓
values.yaml (chart default)
         ↓
values-dev.yaml / values-prod.yaml (environment-specific)
         ↓
Command-line overrides (-f flag)
         ↓
Final Values (Applied to templates)
```

### Creating a New Microservice Chart

```bash
# Create new chart
helm create k8s/helm/ecommerce-newservice

# Update Chart.yaml
# Update values.yaml
# Modify templates/

# Deploy
helm upgrade --install ecommerce-newservice k8s/helm/ecommerce-newservice \
  --namespace ecommerce \
  -f k8s/values-dev.yaml
```

## Production Deployment

### AWS EKS Deployment

```bash
# 1. Create EKS cluster
aws eks create-cluster \
  --name ecommerce-prod \
  --version 1.27 \
  --role-arn arn:aws:iam::ACCOUNT:role/eks-service-role \
  --resources-vpc-config subnetIds=subnet-xxx,subnet-yyy

# 2. Install Istio
./k8s/scripts/install-istio.sh

# 3. Deploy to production
DOMAIN="api.ecommerce.com" ./k8s/scripts/deploy-prod.sh
```

### DigitalOcean Kubernetes

```bash
# 1. Create cluster
doctl kubernetes cluster create ecommerce-prod \
  --version 1.27 \
  --region nyc3 \
  --node-pool-count 3

# 2. Get kubeconfig
doctl kubernetes cluster kubeconfig save ecommerce-prod

# 3. Deploy
./k8s/scripts/deploy-prod.sh
```

### GCP GKE Deployment

```bash
# 1. Create cluster
gcloud container clusters create ecommerce-prod \
  --zone us-central1-a \
  --num-nodes 3 \
  --machine-type n1-standard-2

# 2. Get credentials
gcloud container clusters get-credentials ecommerce-prod

# 3. Deploy
./k8s/scripts/deploy-prod.sh
```

### SSL/TLS Configuration

```bash
# Install cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Create ClusterIssuer for Let's Encrypt
kubectl apply -f - << EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: admin@ecommerce.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: istio
