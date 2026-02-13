#!/usr/bin/env bash
set -euo pipefail
NAMESPACE=${1:-monitoring}

# Prometheus -> localhost:9090
kubectl -n "$NAMESPACE" port-forward svc/kube-prom-stack-prometheus 9090:9090 &
# Grafana -> localhost:3000
kubectl -n "$NAMESPACE" port-forward svc/kube-prom-stack-grafana 3000:80 &

echo "Port-forwarding started: Prometheus -> http://localhost:9090, Grafana -> http://localhost:3000"
