variable "tenant_id" {
  description = "Replace with your Azure AD tenant ID."
  type        = string
}

variable "management_subscription_id" {
  description = "Management Hub subscription ID."
  type        = string
}

variable "network_subscription_id" {
  description = "Network subscription ID."
  type        = string
}

variable "dev_subscription_id" {
  description = "Dev subscription ID."
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
  description = "Short lowercase prefix used in resource names."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
}

variable "log_retention_days" {
  description = "Workspace retention."
  type        = number
}
