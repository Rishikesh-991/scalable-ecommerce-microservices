# Kubernetes Guide

## 1. Scope

This project includes Kubernetes assets under `k8s/` including Helm charts, environment values, Istio configuration, and deployment scripts.

## 2. Directory map

```text
k8s/
├── helm/
│   ├── ecommerce-products/
│   ├── ecommerce-cart/
│   ├── ecommerce-users/
│   ├── ecommerce-search/
│   ├── ecommerce-frontend/
│   ├── ecommerce-postgres/
│   ├── ecommerce-mongodb/
│   └── ecommerce-redis/
├── values-dev.yaml
├── values-prod.yaml
├── scripts/
├── istio/
└── monitoring/
```

## 3. Cluster bootstrapping

### 3.1 Local cluster (Kind)

```bash
bash k8s/scripts/setup-kind-cluster.sh
```

### 3.2 Deploy development environment

```bash
bash k8s/scripts/deploy-dev.sh
```

### 3.3 Deploy production profile

```bash
bash k8s/scripts/deploy-prod.sh
```

## 4. Helm deployment model

- Each service has an independent chart for granular release control.
- Environment-specific overrides are centralized in `values-dev.yaml` and `values-prod.yaml`.
- Recommended process: `helm lint` + `helm template` in CI before merge.

Example:

```bash
helm lint k8s/helm/ecommerce-products
helm template ecommerce-products k8s/helm/ecommerce-products -f k8s/values-dev.yaml
```

## 5. Deployment strategy recommendations

### Current capability

- Standard rolling updates via Kubernetes Deployments.
- Istio resources present for advanced traffic routing (`k8s/istio`).

### Recommended production strategy

- **Default:** rolling updates with readiness probes.
- **High-risk releases:** canary via Istio VirtualService subsets.
- **Critical frontend changes:** blue/green routing with fast rollback.

## 6. Operational checks

```bash
kubectl get pods -A
kubectl describe deployment <name> -n <namespace>
kubectl logs deploy/<name> -n <namespace>
```

## 7. Hardening checklist

- Add resource requests/limits for every workload.
- Enforce liveness/readiness/startup probes.
- Use sealed secrets / external secret operators.
- Add PodDisruptionBudgets for critical services.
- Add network policies per namespace.

## 8. Related docs

- [ARCHITECTURE.md](../architecture/overview.md)
- [DEPLOYMENT_GUIDE.md](../operations/deployment-guide.md)
- [MONITORING.md](../operations/monitoring.md)
