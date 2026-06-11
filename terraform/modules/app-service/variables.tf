variable "name" {
  description = "Globally unique App Service name."
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

variable "service_plan_id" {
  description = "App Service Plan ID."
  type        = string
}

variable "always_on" {
  description = "Keep app warm. Required for many production SKUs."
  type        = bool
  default     = true
}

variable "dotnet_version" {
  description = ".NET stack version."
  type        = string
  default     = "8.0"
}

variable "app_settings" {
  description = "Application settings. Do not place secrets directly here."
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
