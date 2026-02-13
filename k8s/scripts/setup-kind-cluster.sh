#!/bin/bash
# Kind Cluster Setup Script
# Creates a multi-node Kubernetes cluster for development and testing

set -e

CLUSTER_NAME="ecommerce-cluster"
CONFIG_PATH="../kind/cluster-config.yaml"

echo "=== Setting up Kind Cluster: $CLUSTER_NAME ==="

# Check if Kind is installed
if ! command -v kind &> /dev/null; then
    echo "❌ kind is not installed. Installing..."
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

# Check if cluster already exists
if kind get clusters | grep -q "$CLUSTER_NAME"; then
    echo "⚠️  Cluster '$CLUSTER_NAME' already exists. Deleting..."
    kind delete cluster --name="$CLUSTER_NAME"
    sleep 5
fi

# Create storage directory for local volumes
mkdir -p /tmp/kind-storage
sudo chown -R 1000:1000 /tmp/kind-storage

# Create the cluster
echo "📦 Creating Kind cluster..."
kind create cluster --config="$CONFIG_PATH" --name="$CLUSTER_NAME"

# Verify cluster
echo "✅ Verifying cluster..."
kubectl get nodes
kubectl get namespaces

echo ""
echo "=== Cluster Setup Complete ==="
echo "Context: kind-$CLUSTER_NAME"
echo "Next: Install Istio with: ./install-istio.sh"
