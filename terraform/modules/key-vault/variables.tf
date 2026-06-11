variable "name" {
  description = "Globally unique Key Vault name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU."
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Enable purge protection. Use true for prod."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention period."
  type        = number
  default     = 90
}

variable "public_network_access_enabled" {
  description = "Allow public network access for lab simplicity."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
