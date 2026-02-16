# Terraform Guide

## 1. Purpose

Use Terraform to provision cloud infrastructure consistently across environments (dev/stage/prod) and reduce manual operations risk.

> Note: This repository currently focuses on application and Kubernetes assets. This document defines the recommended Terraform standard to adopt.

## 2. Recommended IaC structure

```text
infra/
├── modules/
│   ├── network/
│   ├── kubernetes/
│   ├── databases/
│   └── observability/
└── environments/
    ├── dev/
    ├── stage/
    └── prod/
```

## 3. Remote state and locking

Use remote state with locking to prevent concurrent writes.

Example backend (AWS):

```hcl
terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket"
    key            = "ecommerce/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

## 4. Workflow

```bash
cd infra/environments/dev
terraform init
terraform fmt -check
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

Destroy only in controlled environments:

```bash
terraform destroy
```

## 5. Module design best practices

- Keep modules small and composable.
- Expose only necessary outputs.
- Validate input variables.
- Tag all resources (`environment`, `owner`, `service`, `cost-center`).
- Pin provider versions.

## 6. Promotion model

1. Apply in `dev`.
2. Validate workload behavior and monitoring.
3. Promote to `stage`.
4. Run change approval.
5. Promote to `prod` with immutable version references.

## 7. Security and compliance

- Never commit credentials in Terraform files or state.
- Prefer workload identity/role-based auth.
- Run static analysis (e.g., `tfsec`, `checkov`) in CI.
- Keep state access restricted via least privilege.

## 8. Related docs

- [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
- [SECURITY.md](./SECURITY.md)
