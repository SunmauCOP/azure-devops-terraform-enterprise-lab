provider "azurerm" {
  features {}
  subscription_id = var.dev_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "dev"
  features {}
  subscription_id = var.dev_subscription_id
  tenant_id       = var.tenant_id
}
