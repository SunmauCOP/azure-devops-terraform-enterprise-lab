# Security Best Practices

Owner on all subscriptions is acceptable only for a learning lab. Production should use least privilege.

Recommended RBAC:

- Contributor at the target resource group or subscription scope.
- Storage Blob Data Contributor on the Terraform state container.
- User Access Administrator only when Terraform creates RBAC assignments.
- Custom role for constrained Terraform operations where practical.

Protect secrets with Azure Key Vault, secure variables, GitHub secrets, or OIDC. Do not commit secrets or local `.tfstate` files.

Use Checkov or tfsec for IaC scanning, dependency review for workflows, branch protection, audit logs, and Azure Policy.
