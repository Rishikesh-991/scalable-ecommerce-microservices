#!/bin/bash
# Production Deployment Script

set -e

NAMESPACE="ecommerce-prod"
ENVIRONMENT="prod"
DOMAIN=${DOMAIN:-"ecommerce.production.local"}

echo "=== Deploying to $ENVIRONMENT environment ==="

# Create namespace
kubectl create namespace $NAMESPACE 2>/dev/null || true

# Deploy with production values
echo "📦 Deploying to production..."

# Update ingress values for production
cat > /tmp/prod-values.yaml << YAML
global:
  environment: prod
  domain: $DOMAIN

replicaCount: 3

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10

ingress:
  enabled: true
  className: istio
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  tls:
    - secretName: ecommerce-tls
      hosts:
        - $DOMAIN
YAML

# Deploy all services with production config
for service in frontend products search users cart; do
  helm upgrade --install ecommerce-$service ../helm/ecommerce-$service \
    --namespace $NAMESPACE \
    -f ../helm/ecommerce-$service/values.yaml \
    -f /tmp/prod-values.yaml
done

# Deploy databases with prod-specific settings
helm upgrade --install postgresql ../helm/ecommerce-postgres \
  --namespace $NAMESPACE \
  --set postgresql.primary.persistence.size=50Gi \
  --set postgresql.primary.resources.requests.cpu=500m

helm upgrade --install mongodb ../helm/ecommerce-mongodb \
  --namespace $NAMESPACE \
  --set mongodb.persistence.size=50Gi \
  --set mongodb.primary.resources.requests.cpu=500m

echo "✅ Production deployment complete!"
echo "Domain: $DOMAIN"
