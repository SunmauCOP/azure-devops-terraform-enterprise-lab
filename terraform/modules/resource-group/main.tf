# Creates a resource group as the deployment boundary for an environment workload.
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
