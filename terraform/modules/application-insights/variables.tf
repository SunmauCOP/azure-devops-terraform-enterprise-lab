variable "name" {
  description = "Application Insights name."
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

variable "application_type" {
  description = "Application type."
  type        = string
  default     = "web"
}

variable "workspace_id" {
  description = "Log Analytics workspace resource ID."
  type        = string
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
