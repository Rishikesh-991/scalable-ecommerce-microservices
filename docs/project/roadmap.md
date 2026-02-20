# Roadmap

This roadmap communicates delivery direction and platform maturity priorities.

## Current state

### In place
- Multi-service architecture with polyglot backend
- Docker-based local workflow
- Kubernetes Helm chart assets
- Initial monitoring deployment script and dashboard assets

### Needs hardening
- Fully active CI pipelines (some existing workflow files are currently commented)
- Consistent automated test/lint coverage across all services
- Standardized security scanning in CI

## Near-term (0–3 months)

- [ ] Enable CI checks for lint, unit tests, and image builds
- [ ] Add health/readiness probes to every runtime service
- [ ] Define and enforce branch protection + required checks
- [ ] Standardize structured JSON logging with correlation IDs
- [ ] Add contributor templates (issues/PRs)

## Mid-term (3–6 months)

- [ ] Add OpenTelemetry traces and service map
- [ ] Introduce canary deployment policy in Kubernetes
- [ ] Add centralized secret management for clusters
- [ ] Build Terraform modules for cloud environments
- [ ] Publish performance baseline (latency/throughput)

## Long-term (6+ months)

- [ ] Multi-region deployment and failover design
- [ ] Advanced reliability controls (error budgets, release gates)
- [ ] Cost optimization dashboards and autoscaling policy tuning
- [ ] Event contract governance and schema registry practices

## Portfolio impact goals

To impress reviewers and hiring teams, prioritize:
1. Operational excellence signals (CI + monitoring + security)
2. Clear architecture narratives and trade-off documentation
3. Measurable outcomes (SLOs, latency, reliability improvements)
