# Interview Explanation

## How did you design the Terraform structure?

I used separate deployable roots for management, network, dev, and prod. Each root has its own backend state key, variables, provider configuration, and environment values. Shared infrastructure patterns are placed in reusable modules.

## Why did you use modules?

Modules standardize naming, tags, security settings, and outputs. They reduce copy-paste and make it easier to enforce enterprise patterns such as TLS, soft delete, managed identity, and private endpoint readiness.

## How did you manage state?

State is remote in Azure Blob Storage with separate state files per environment. The backend account enables versioning and soft delete so accidental state corruption can be recovered.

## How did you separate environments?

Each subscription has its own Terraform root and backend key. Dev and prod use the same modules but different tfvars, SKUs, tags, retention, and approvals.

## How did you secure the pipeline?

Secrets are kept out of code. Pipelines use service connections, secure variables, Key Vault integration, or OIDC. PRs run validation and security scanning before merge.

## How did you implement release governance?

Plan and apply are separated. Plans are published as artifacts. Production apply requires approval through Azure DevOps Environments or GitHub Environments.

## How would you improve this for a real enterprise?

I would add management groups, policy initiatives, private endpoints by default, centralized DNS, Defender for Cloud exports, workload identity federation, separate plan/apply identities, and automated post-deployment tests.

## How do you manage rollback and drift?

Rollback is usually a forward fix through Terraform. For severe issues, restore previous variables or module version and apply. Drift is detected by scheduled plan jobs and reviewed before remediation.
