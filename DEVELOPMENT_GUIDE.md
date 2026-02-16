# Development Guide

## 1. Engineering principles

- Keep services independently deployable.
- Prefer small, reviewable pull requests.
- Maintain clear contracts between services.
- Treat documentation updates as part of feature delivery.

## 2. Branch strategy

Recommended Git flow:
- `main`: stable branch
- `feature/<topic>`: feature development
- `fix/<topic>`: bug fixes
- `docs/<topic>`: documentation-only updates

Example:

```bash
git checkout -b docs/kubernetes-guide-refresh
```

## 3. Local setup

Follow [QUICK_START.md](./QUICK_START.md) for environment bootstrapping and service startup.

## 4. Code quality checks

Run relevant checks before opening a PR:

```bash
# Node services
npm run lint
npm test

# Python services
python -m pytest
ruff check .

# Java services
./gradlew test
```

If a service does not yet include these scripts, add them as part of a quality-improvement PR.

## 5. Commit standards

Use Conventional Commit style:
- `feat:` feature
- `fix:` bug fix
- `docs:` docs only
- `chore:` maintenance

Examples:

```text
docs: add terraform workflow documentation
fix(cart): validate negative quantity updates
```

## 6. Pull request checklist

- [ ] Scope is clear and minimal
- [ ] Tests updated or rationale documented
- [ ] Documentation updated
- [ ] Security impact reviewed
- [ ] Rollback plan included for runtime changes

## 7. Pre-commit recommendations

Use pre-commit hooks to reduce review churn.

Example `.pre-commit-config.yaml` tools:
- markdownlint
- yamllint
- trailing-whitespace
- end-of-file-fixer
- secret scanners (gitleaks/trufflehog)

## 8. Definition of done

A change is complete when:
1. It is tested.
2. It is documented.
3. It is observable.
4. It is secure by default.
