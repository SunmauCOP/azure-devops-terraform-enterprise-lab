locals {
  tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "azure-devops-terraform-enterprise-lab"
  })
}

module "management_rg" {
  source = "../../modules/resource-group"
  providers = {
    azurerm = azurerm.management
  }

  name     = "rg-${var.naming_prefix}-${var.environment}-platform-001"
  location = var.location
  tags     = local.tags
}

module "log_analytics" {
  source = "../../modules/log-analytics"
  providers = {
    azurerm = azurerm.management
  }

  name                = "law-${var.naming_prefix}-${var.environment}-001"
  location            = module.management_rg.location
  resource_group_name = module.management_rg.name
  retention_in_days   = var.log_retention_days
  tags                = local.tags
}

module "key_vault" {
  source = "../../modules/key-vault"
  providers = {
    azurerm = azurerm.management
  }

  name                = "kv${var.naming_prefix}${var.environment}001"
  location            = module.management_rg.location
  resource_group_name = module.management_rg.name
  tenant_id           = var.tenant_id
  tags                = local.tags
}

module "audit_storage" {
  source = "../../modules/storage-account"
  providers = {
    azurerm = azurerm.management
  }

  name                     = "st${var.naming_prefix}${var.environment}audit001"
  location                 = module.management_rg.location
  resource_group_name      = module.management_rg.name
  account_replication_type = "ZRS"
  tags                     = local.tags
}

# Placeholder: add diagnostic settings for activity logs and platform resources here.
