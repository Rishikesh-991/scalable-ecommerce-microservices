# Security Guide

## 1. Security posture

This project follows a defense-in-depth model across code, dependencies, infrastructure, and runtime operations.

## 2. Threat model summary

### Key assets
- User identity and profile data
- Payment workflow integrity
- Order/cart business data
- Service credentials and tokens

### Primary threats
- Credential leakage
- Injection and API abuse
- Dependency vulnerabilities
- Lateral movement in cluster environments

## 3. Secure development requirements

- Validate all external input at service boundaries.
- Use parameterized DB operations and safe ORM patterns.
- Enforce authZ checks on protected endpoints.
- Avoid verbose error messages in production.

## 4. Secrets management

- Never commit secrets in source control.
- Keep local secrets in ignored `.env` files.
- In Kubernetes, prefer external secret management (Vault/External Secrets/Sealed Secrets).
- Rotate credentials regularly and after incidents.

## 5. Dependency and image scanning

Recommended CI checks:
- SCA (e.g., `npm audit`, `pip-audit`, `owasp dependency-check`)
- Container scan (e.g., Trivy, Grype)
- IaC scan (e.g., tfsec, checkov)

Example:

```bash
trivy image ghcr.io/<org>/products:<git-sha>
```

## 6. Runtime controls

- Enforce least privilege RBAC.
- Add Kubernetes NetworkPolicies.
- Use non-root containers.
- Enable audit logging where supported.

## 7. Incident response

If you discover a vulnerability:
1. Do **not** open a public issue with exploit details.
2. Report privately to maintainers.
3. Include reproduction steps, impact, and suggested mitigation.
4. Coordinate disclosure timeline after patch verification.

## 8. Security checklist

- [ ] No hardcoded credentials
- [ ] Dependencies scanned
- [ ] Images scanned
- [ ] Secrets rotation policy documented
- [ ] Access logs and audit trails enabled

## 9. Related docs

- [MONITORING.md](./MONITORING.md)
- [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
