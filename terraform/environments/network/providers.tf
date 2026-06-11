provider "azurerm" {
  features {}
  subscription_id = var.network_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "management"
  features {}
  subscription_id = var.management_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "network"
  features {}
  subscription_id = var.network_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "dev"
  features {}
  subscription_id = var.dev_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "prod"
  features {}
  subscription_id = var.prod_subscription_id
  tenant_id       = var.tenant_id
}
