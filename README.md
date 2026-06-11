# Azure DevOps Terraform Enterprise Lab

This repository is a hands-on enterprise-style lab for deploying Azure infrastructure with Terraform, GitHub, GitHub Actions, Azure DevOps Pipelines, and Azure DevOps release governance.

The design assumes four Azure subscriptions:

- Management Hub Subscription
- Network Subscription
- Dev Subscription
- Prod Subscription

For lab speed, one service principal can have Owner on all subscriptions. For production, split identities by environment and scope them with least privilege.

## Architecture

- `terraform/modules` contains reusable building blocks.
- `terraform/environments` contains deployable roots with separate state files.
- `terraform/backend` stores backend configuration for each root.
- `pipelines/azure-devops` shows PR validation, manual plan/apply, templates, and a multi-stage release.
- `pipelines/github-actions` shows the GitHub Actions alternative.
- `governance` documents branch policy, release control, rollback, and change management.

## Prerequisites

- Terraform 1.6 or newer
- Azure CLI
- Git
- PowerShell 7 recommended
- GitHub repository
- Azure DevOps project, service connections, variable groups, environments, and approvals

## First-Time Setup

1. Replace all `REPLACE-WITH-*` values in `terraform/environments/*/terraform.tfvars`.
2. Create remote state storage:

```powershell
./scripts/create-tfstate-storage.ps1 -SubscriptionId "<management-subscription-id>" -StorageAccountName "<globally-unique-name>"
```

3. Replace `REPLACE_WITH_TFSTATE_STORAGE` in `terraform/backend/*.backend.tfvars`.
4. Authenticate locally:

```powershell
az login
$env:ARM_CLIENT_ID = "<client-id>"
$env:ARM_CLIENT_SECRET = "<client-secret>"
$env:ARM_TENANT_ID = "<tenant-id>"
```

5. Run Terraform locally:

```powershell
cd terraform/environments/dev
terraform init -backend-config="../../backend/dev.backend.tfvars"
terraform fmt -recursive
terraform validate
terraform plan
```

## Azure DevOps Setup

Create service connections:

- `sc-azure-nonprod-terraform`
- `sc-azure-prod-terraform`

Create variable group `vg-terraform-common` and store non-secret values. Store secrets as secure variables or link Azure Key Vault.

Create Azure DevOps Environments:

- `dev`
- `prod`

Add approval checks to `prod`. Require plan review before apply.

## GitHub Actions Setup

Add repository or environment secrets:

- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_TENANT_ID`
- `ARM_SUBSCRIPTION_ID`

Preferred production pattern: use OIDC federation instead of `ARM_CLIENT_SECRET`.

## Promotion Flow

1. Developer creates feature branch.
2. Pull request runs fmt, validate, plan, and security scan.
3. Reviewer checks Terraform plan artifact.
4. Merge to `main`.
5. Multi-stage pipeline deploys dev.
6. Prod plan is generated and reviewed.
7. Prod approval is granted.
8. Prod apply runs from the reviewed plan.
9. Post-deployment checks validate resources and monitoring.

## Troubleshooting

- Backend access errors: confirm the service principal has Storage Blob Data Contributor on the state storage account.
- Provider auth errors: confirm `ARM_*` values or service connection configuration.
- Name conflicts: storage accounts, Key Vaults, and Web Apps need globally unique names.
- Policy failures: inspect Azure Policy compliance and the denied operation details.

## Interview Value

This lab demonstrates modular Terraform, remote state, multi-subscription deployment, CI/CD validation, plan/apply separation, production approvals, secret management, and governance. See `docs/08-interview-explanation.md`.
