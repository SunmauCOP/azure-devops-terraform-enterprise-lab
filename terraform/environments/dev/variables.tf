variable "tenant_id" {
  description = "Replace with your Azure AD tenant ID."
  type        = string
}

variable "dev_subscription_id" {
  description = "Dev subscription ID."
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
  description = "App Service Plan SKU."
  type        = string
}

variable "storage_replication_type" {
  description = "Storage replication type."
  type        = string
}

variable "log_retention_days" {
  description = "Workspace retention."
  type        = number
}
