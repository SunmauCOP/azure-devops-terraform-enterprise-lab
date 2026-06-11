locals {
  tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    LandingZone = "Connectivity"
  })
}

module "network_rg" {
  source = "../../modules/resource-group"
  providers = {
    azurerm = azurerm.network
  }
  name     = "rg-${var.naming_prefix}-${var.environment}-hub-001"
  location = var.location
  tags     = local.tags
}

module "hub_nsg" {
  source = "../../modules/nsg"
  providers = {
    azurerm = azurerm.network
  }
  name                = "nsg-${var.naming_prefix}-${var.environment}-hub-001"
  location            = module.network_rg.location
  resource_group_name = module.network_rg.name
  tags                = local.tags
}

module "hub_route_table" {
  source = "../../modules/route-table"
  providers = {
    azurerm = azurerm.network
  }
  name                = "rt-${var.naming_prefix}-${var.environment}-hub-001"
  location            = module.network_rg.location
  resource_group_name = module.network_rg.name
  tags                = local.tags

  # Placeholder: when Azure Firewall is added, create default routes to the firewall private IP.
  routes = []
}

module "hub_vnet" {
  source = "../../modules/virtual-network"
  providers = {
    azurerm = azurerm.network
  }
  name                = "vnet-${var.naming_prefix}-${var.environment}-hub-001"
  location            = module.network_rg.location
  resource_group_name = module.network_rg.name
  address_space       = var.hub_address_space
  tags                = local.tags
}

module "hub_subnets" {
  source = "../../modules/subnet"
  providers = {
    azurerm = azurerm.network
  }
  for_each                  = var.subnets
  name                      = each.key
  resource_group_name       = module.network_rg.name
  virtual_network_name      = module.hub_vnet.name
  address_prefixes          = each.value.address_prefixes
  network_security_group_id = module.hub_nsg.id
  route_table_id            = module.hub_route_table.id
}

# Placeholder: add azurerm_firewall, private DNS zones, VNet peering, and DNS resolver here.
