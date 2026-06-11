variable "name" {
  description = "App Service Plan name."
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

variable "os_type" {
  description = "Linux or Windows."
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "SKU, for example B1, P1v3."
  type        = string
  default     = "B1"
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
