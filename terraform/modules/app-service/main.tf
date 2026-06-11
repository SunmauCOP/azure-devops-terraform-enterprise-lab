resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  https_only          = true
  tags                = var.tags

  site_config {
    always_on           = var.always_on
    minimum_tls_version = "1.2"

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }
}
