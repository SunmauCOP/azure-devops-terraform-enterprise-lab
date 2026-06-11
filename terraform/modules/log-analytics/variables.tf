variable "name" {
  description = "Log Analytics workspace name."
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

variable "sku" {
  description = "Workspace SKU."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Log retention days."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
