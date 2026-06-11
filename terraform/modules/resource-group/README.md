# Resource Group Module

Creates a tagged Azure resource group. In an enterprise landing zone, resource groups are usually aligned to workload, environment, lifecycle, and ownership boundaries.

## Example

```hcl
module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-app-dev-001"
  location = var.location
  tags     = local.tags
}
```
