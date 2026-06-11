resource "azurerm_subnet" "this" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = var.network_security_group_id == null ? 0 : 1
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_subnet_route_table_association" "this" {
  count          = var.route_table_id == null ? 0 : 1
  subnet_id      = azurerm_subnet.this.id
  route_table_id = var.route_table_id
}
