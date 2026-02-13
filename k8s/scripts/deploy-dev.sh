#!/bin/bash
# Development Environment Deployment Script

set -e

NAMESPACE="ecommerce"
ENVIRONMENT="dev"

echo "=== Deploying to $ENVIRONMENT environment ==="

# Create namespace if not exists
kubectl create namespace $NAMESPACE 2>/dev/null || true

# Create local-storage StorageClass
kubectl apply -f - << YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
YAML

# Deploy databases
echo "📦 Deploying databases..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade --install postgresql ../helm/ecommerce-postgres \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-postgres/values.yaml \
  --set postgresql.primary.persistence.storageClassName=local-storage

helm upgrade --install mongodb ../helm/ecommerce-mongodb \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-mongodb/values.yaml \
  --set mongodb.persistence.storageClassName=local-storage

helm upgrade --install redis ../helm/ecommerce-redis \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-redis/values.yaml

# Wait for databases
echo "⏳ Waiting for databases..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=postgresql -n $NAMESPACE --timeout=300s 2>/dev/null || true
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=mongodb -n $NAMESPACE --timeout=300s 2>/dev/null || true

# Deploy microservices
echo "📦 Deploying microservices..."
helm upgrade --install ecommerce-frontend ../helm/ecommerce-frontend \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-frontend/values.yaml

helm upgrade --install ecommerce-products ../helm/ecommerce-products \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-products/values.yaml

helm upgrade --install ecommerce-search ../helm/ecommerce-search \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-search/values.yaml

helm upgrade --install ecommerce-users ../helm/ecommerce-users \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-users/values.yaml

helm upgrade --install ecommerce-cart ../helm/ecommerce-cart \
  --namespace $NAMESPACE \
  --values ../helm/ecommerce-cart/values.yaml

# Deploy Istio resources
echo "🌐 Configuring Istio..."
kubectl apply -f ../istio/namespace.yaml
kubectl apply -f ../istio/gateway.yaml
kubectl apply -f ../istio/virtual-services.yaml
kubectl apply -f ../istio/destination-rules.yaml
kubectl apply -f ../istio/mtls-policy.yaml

echo "✅ Deployment complete!"
echo ""
echo "Access points:"
echo "  Frontend:  http://localhost:8080"
echo "  Products:  http://products.localhost:8080"
echo "  Users:     http://users.localhost:8080"
echo ""
echo "Port forward: kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80"
