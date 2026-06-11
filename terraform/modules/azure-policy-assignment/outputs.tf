output "id" {
  value = try(azurerm_subscription_policy_assignment.this[0].id, azurerm_resource_group_policy_assignment.this[0].id)
}
