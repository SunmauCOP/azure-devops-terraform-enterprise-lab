output "id" {
  value       = azurerm_virtual_network.this.id
  description = "Virtual network resource ID."
}

output "name" {
  value       = azurerm_virtual_network.this.name
  description = "Virtual network name."
}
