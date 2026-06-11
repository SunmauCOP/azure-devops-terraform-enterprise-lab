# Terraform Backend Setup

Terraform state is stored in Azure Blob Storage. Each environment has a separate key:

- `management-hub/terraform.tfstate`
- `network/terraform.tfstate`
- `dev/terraform.tfstate`
- `prod/terraform.tfstate`

Use `scripts/create-tfstate-storage.ps1` to create the backend account with versioning, soft delete, TLS 1.2, and no anonymous blob access.

Production hardening: private endpoint, storage firewall, customer-managed keys if required, diagnostic settings, and restricted data-plane RBAC.
