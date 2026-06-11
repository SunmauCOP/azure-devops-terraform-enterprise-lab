resource "azurerm_storage_account" "this" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.public_network_access_enabled
  tags                            = var.tags

  blob_properties {
    versioning_enabled = var.blob_versioning_enabled
    delete_retention_policy {
      days = var.blob_soft_delete_days
    }
    container_delete_retention_policy {
      days = var.container_soft_delete_days
    }
  }
}
