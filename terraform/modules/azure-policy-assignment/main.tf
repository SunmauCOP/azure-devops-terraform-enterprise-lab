resource "azurerm_resource_group_policy_assignment" "this" {
  count                = var.scope_type == "resource_group" ? 1 : 0
  name                 = var.name
  resource_group_id    = var.scope_id
  policy_definition_id = var.policy_definition_id
  display_name         = var.display_name
  description          = var.description
  parameters           = var.parameters_json
  location             = var.location

  dynamic "identity" {
    for_each = var.enable_managed_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
}

resource "azurerm_subscription_policy_assignment" "this" {
  count                = var.scope_type == "subscription" ? 1 : 0
  name                 = var.name
  subscription_id      = var.scope_id
  policy_definition_id = var.policy_definition_id
  display_name         = var.display_name
  description          = var.description
  parameters           = var.parameters_json
  location             = var.location

  dynamic "identity" {
    for_each = var.enable_managed_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
}
