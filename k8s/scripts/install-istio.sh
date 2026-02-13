#!/bin/bash
# Istio Installation and Configuration Script

set -e

ISTIO_VERSION="1.18.0"
ISTIO_NAMESPACE="istio-system"

echo "=== Installing Istio $ISTIO_VERSION ==="

# Download Istio
if [ ! -d "istio-$ISTIO_VERSION" ]; then
    echo "📥 Downloading Istio $ISTIO_VERSION..."
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VERSION sh -
fi

cd istio-$ISTIO_VERSION

# Create istio-system namespace
kubectl create namespace $ISTIO_NAMESPACE 2>/dev/null || true

# Install Istio using Helm (or istioctl)
echo "📦 Installing Istio control plane..."
./bin/istioctl install --set profile=demo -y

# Wait for Istio to be ready
echo "⏳ Waiting for Istio to be ready..."
kubectl wait --for=condition=ready pod -l app=istiod -n $ISTIO_NAMESPACE --timeout=300s

# Enable sidecar injection for ecommerce namespace
echo "🔌 Configuring sidecar injection..."
kubectl label namespace ecommerce istio-injection=enabled --overwrite

echo "✅ Istio installation complete!"
echo "Dashboard: istioctl dashboard kiali"
