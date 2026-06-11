# Rollback Plan

Terraform rollback is a controlled forward deployment.

1. Identify failed change.
2. Revert code or variables.
3. Generate new plan.
4. Review impact.
5. Apply approved correction.
6. Validate service health.

Use Azure-native backup or restore features for data-plane recovery.
