# Monitoring and Observability

## 1. Objectives

Monitoring must answer four operational questions quickly:
1. Is the platform up?
2. Are users impacted?
3. Which service is failing?
4. What changed?

## 2. Stack

- **Metrics:** Prometheus
- **Dashboards:** Grafana
- **Deployment helper:** `k8s/scripts/deploy-monitoring.sh`
- **Dashboard asset:** `k8s/monitoring/grafana/dashboards/ecommerce-overview.json`

Deploy monitoring stack:

```bash
bash k8s/scripts/deploy-monitoring.sh monitoring
```

## 3. Health checks

Each service should expose:
- **Liveness:** process is healthy
- **Readiness:** service can receive traffic
- **Startup:** app boot completed

Example readiness endpoint pattern:

```http
GET /health/ready
200 OK
{
  "status": "ready",
  "dependencies": {
    "database": "up",
    "queue": "up"
  }
}
```

## 4. Golden signals

Track these for each service:
- **Latency** (p95/p99)
- **Traffic** (RPS)
- **Errors** (4xx/5xx, exception rates)
- **Saturation** (CPU/memory/queue depth)

## 5. Logging standard

Use structured JSON logs with correlation identifiers.

Example:

```json
{
  "timestamp": "2026-02-16T12:00:00Z",
  "level": "INFO",
  "service": "products-api",
  "trace_id": "6d2087f6...",
  "span_id": "89ac12...",
  "request_id": "req-123",
  "path": "/products",
  "method": "GET",
  "status": 200,
  "duration_ms": 23
}
```

## 6. Alerting recommendations

Define alert rules for:
- Error rate spike (>2–5% sustained)
- p95 latency threshold breaches
- Pod crash loops / restart storms
- Database connectivity failures

Integrate Alertmanager with Slack/Email/PagerDuty for incident escalation.

## 7. SLO baseline (recommended)

- API availability: **99.9% monthly**
- p95 latency: **< 300ms** for core read endpoints
- Error budget policy: release freeze if budget burn exceeds threshold

## 8. Related docs

- [KUBERNETES.md](./KUBERNETES.md)
- [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
- [SECURITY.md](./SECURITY.md)
