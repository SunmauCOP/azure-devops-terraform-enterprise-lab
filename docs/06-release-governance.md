# Release Governance

Release governance protects production from accidental or unreviewed change.

Flow:

1. Feature branch.
2. Pull request.
3. Terraform fmt, validate, and security scan.
4. Terraform plan artifact.
5. Human plan review.
6. Merge to main.
7. Dev deployment.
8. Prod plan.
9. Manual approval.
10. Prod apply.
11. Post-deployment validation.

Connect production releases to change records when working in a regulated enterprise.
