# Deployment Guide

## 1. Deployment goals

- Predictable releases
- Fast rollback
- Environment consistency
- Minimal downtime

## 2. Environment model

- **Dev:** active feature integration and validation
- **Stage:** production-like validation and non-functional testing
- **Prod:** customer-facing stable environment

## 3. Artifact strategy

Use immutable image tags based on commit SHA:

```text
ghcr.io/<org>/products:<git-sha>
```

Avoid mutable tags (`latest`) in production manifests.

## 4. Kubernetes deployment flow

### 4.1 Pre-deploy checks

```bash
helm lint k8s/helm/ecommerce-products
helm template ecommerce-products k8s/helm/ecommerce-products -f k8s/values-prod.yaml
```

### 4.2 Deploy

```bash
bash k8s/scripts/deploy-prod.sh
```

### 4.3 Post-deploy validation

```bash
kubectl get deploy,pods,svc -n ecommerce
kubectl rollout status deploy/<service> -n ecommerce
```

## 5. Deployment strategies

- **Rolling updates:** default for low-risk changes
- **Canary:** for risky API/runtime changes
- **Blue/green:** for frontend and major workflow changes

## 6. Rollback playbook

1. Identify failing release revision.
2. Roll back Helm release:

```bash
helm history <release> -n ecommerce
helm rollback <release> <revision> -n ecommerce
```

3. Validate service health and key user journeys.
4. Open incident review and capture follow-up actions.

## 7. Release checklist

- [ ] Build and tests passed
- [ ] Security scan passed
- [ ] Helm templates validated
- [ ] Monitoring and alerts verified
- [ ] Rollback command tested

## 8. Related docs

- [KUBERNETES.md](../deployment/kubernetes.md)
- [MONITORING.md](./monitoring.md)
- [SECURITY.md](../security/security.md)
