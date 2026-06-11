# GitHub Actions Setup

The workflows under `pipelines/github-actions` provide plan, apply, and security scan examples. Copy them to `.github/workflows` when you want GitHub to run them.

Use GitHub Environments for `dev` and `prod`. Add required reviewers to `prod`.

Prefer OIDC federation:

1. Create federated credential on the Azure app registration.
2. Grant GitHub workflow `id-token: write`.
3. Use `azure/login` without a client secret.
