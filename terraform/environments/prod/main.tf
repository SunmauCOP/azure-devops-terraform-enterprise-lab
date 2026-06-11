locals {
  tags = merge(var.tags, {
    Environment      = var.environment
    ManagedBy        = "Terraform"
    Workload         = "SampleWebApp"
    ChangeControl    = "Required"
    BusinessCritical = "true"
  })
}

module "rg" {
  source = "../../modules/resource-group"
  providers = {
    azurerm = azurerm.prod
  }
  name     = "rg-${var.naming_prefix}-${var.environment}-app-001"
  location = var.location
  tags     = local.tags
}

module "log_analytics" {
  source = "../../modules/log-analytics"
  providers = {
    azurerm = azurerm.prod
  }
  name                = "law-${var.naming_prefix}-${var.environment}-001"
  location            = module.rg.location
  resource_group_name = module.rg.name
  retention_in_days   = var.log_retention_days
  tags                = local.tags
}

module "app_insights" {
  source = "../../modules/application-insights"
  providers = {
    azurerm = azurerm.prod
  }
  name                = "appi-${var.naming_prefix}-${var.environment}-001"
  location            = module.rg.location
  resource_group_name = module.rg.name
  workspace_id        = module.log_analytics.id
  tags                = local.tags
}

module "key_vault" {
  source = "../../modules/key-vault"
  providers = {
    azurerm = azurerm.prod
  }
  name                          = "kv${var.naming_prefix}${var.environment}app001"
  location                      = module.rg.location
  resource_group_name           = module.rg.name
  tenant_id                     = var.tenant_id
  purge_protection_enabled      = true
  public_network_access_enabled = true
  tags                          = local.tags
}

module "storage" {
  source = "../../modules/storage-account"
  providers = {
    azurerm = azurerm.prod
  }
  name                     = "st${var.naming_prefix}${var.environment}app001"
  location                 = module.rg.location
  resource_group_name      = module.rg.name
  account_replication_type = var.storage_replication_type
  tags                     = local.tags
}

module "plan" {
  source = "../../modules/app-service-plan"
  providers = {
    azurerm = azurerm.prod
  }
  name                = "asp-${var.naming_prefix}-${var.environment}-001"
  location            = module.rg.location
  resource_group_name = module.rg.name
  sku_name            = var.app_service_plan_sku
  tags                = local.tags
}

module "web_app" {
  source = "../../modules/app-service"
  providers = {
    azurerm = azurerm.prod
  }
  name                = "app-${var.naming_prefix}-${var.environment}-001"
  location            = module.rg.location
  resource_group_name = module.rg.name
  service_plan_id     = module.plan.id
  always_on           = true
  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = module.app_insights.connection_string
    ENVIRONMENT                           = var.environment
  }
  tags = local.tags
}

# Production notes:
# - Add private endpoints and disable public access once private DNS is integrated.
# - Add backup and DR policies for app content and data stores.
# - Use Azure Policy to enforce diagnostics, allowed locations, SKUs, and tags.
