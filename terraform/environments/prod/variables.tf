variable "tenant_id" {
  description = "Replace with your Azure AD tenant ID."
  type        = string
}

variable "prod_subscription_id" {
  description = "Prod subscription ID."
  type        = string
}

variable "location" {
  description = "Primary Azure region."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "naming_prefix" {
  description = "Short lowercase prefix."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
}

variable "app_service_plan_sku" {
  description = "Production App Service Plan SKU."
  type        = string
}

variable "storage_replication_type" {
  description = "Production storage replication type."
  type        = string
}

variable "log_retention_days" {
  description = "Workspace retention."
  type        = number
}
