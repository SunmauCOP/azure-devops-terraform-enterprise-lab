provider "azurerm" {
  features {}
  subscription_id = var.prod_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "prod"
  features {}
  subscription_id = var.prod_subscription_id
  tenant_id       = var.tenant_id
}
