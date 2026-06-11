variable "name" {
  description = "Globally unique storage account name, 3-24 lowercase alphanumeric chars."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage account names must be 3-24 chars, lowercase letters and numbers only."
  }
}
variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "account_tier" {
  description = "Standard or Premium."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "LRS, ZRS, GRS, or RAGRS."
  type        = string
  default     = "LRS"
}

variable "public_network_access_enabled" {
  description = "Allow public endpoint for lab simplicity."
  type        = bool
  default     = true
}

variable "blob_versioning_enabled" {
  description = "Enable blob versioning."
  type        = bool
  default     = true
}

variable "blob_soft_delete_days" {
  description = "Blob soft delete days."
  type        = number
  default     = 14
}

variable "container_soft_delete_days" {
  description = "Container soft delete days."
  type        = number
  default     = 14
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
