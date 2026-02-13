#!/usr/bin/env bash
set -euo pipefail

# Deploy Prometheus & Grafana using kube-prometheus-stack
# Usage: ./deploy-monitoring.sh [namespace]
NAMESPACE=${1:-monitoring}

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

# Install kube-prometheus-stack (Prometheus + Alertmanager + Grafana)
helm upgrade --install kube-prom-stack prometheus-community/kube-prometheus-stack \
  --namespace "$NAMESPACE" \
  -f - <<EOF
prometheus:
  prometheusSpec:
    serviceMonitorSelectorNilUsesHelmValues: false
grafana:
  enabled: true
  adminUser: admin
  adminPassword: admin
  grafana.ini:
    server:
      root_url: http://localhost:3000
  sidecar:
    dashboards:
      enabled: true
