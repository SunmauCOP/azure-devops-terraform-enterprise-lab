# Azure DevOps Setup

Use Azure Repos or connect Azure DevOps Pipelines to GitHub. Create service connections for non-prod and prod. Create variable groups for shared values and link Azure Key Vault for secrets.

Recommended controls:

- Branch policy requires PR review.
- Build validation runs the PR validation pipeline.
- Prod environment requires manual approval.
- Pipeline artifacts store plan files and readable plan output.
- Secure files and variables are limited to pipeline administrators.
