# Contributing Guide

Thank you for contributing. This guide defines the expected workflow for high-quality, reviewable contributions.

## 1. Before you start

- Read [README.md](../../README.md) and [DEVELOPMENT_GUIDE.md](../operations/development-guide.md).
- Search existing issues/PRs to avoid duplicate work.
- For significant changes, open an issue first to align on scope.

## 2. Contribution workflow

1. Fork and clone the repository.
2. Create a focused branch.
3. Implement and test changes.
4. Update docs when behavior changes.
5. Open a pull request with clear context.

```bash
git checkout -b feature/<short-description>
```

## 3. Pull request standards

Include in every PR:
- Problem statement
- What changed
- Why this approach
- Testing evidence
- Rollback/risk notes (if runtime impact)

PRs that skip tests or documentation may be asked to revise before merge.

## 4. Commit message style

Use Conventional Commits:

```text
feat(products): add inventory reservation endpoint
fix(users): handle duplicate email gracefully
docs: update quick start for helm deployment
```

## 5. Code and documentation quality

- Keep changes minimal and modular.
- Prefer readability over cleverness.
- Use consistent naming and formatting.
- Update documentation in the same PR as code changes.

## 6. Reporting bugs

Please include:
- Reproduction steps
- Expected vs actual result
- Environment details
- Logs/screenshots if available

## 7. Security issues

For sensitive vulnerabilities, follow [SECURITY.md](../security/security.md) and report privately.

## 8. Code of Conduct

By participating, you agree to follow [CODE_OF_CONDUCT.md](./code-of-conduct.md).
