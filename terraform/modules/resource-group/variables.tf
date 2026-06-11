variable "name" {
  description = "Resource group name. Example: rg-dev-app-001."
  type        = string
  validation {
    condition     = can(regex("^rg-[a-z0-9-]+$", var.name))
    error_message = "Use the naming pattern rg-<workload>-<environment>-<sequence>."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Enterprise tags inherited by all resources."
  type        = map(string)
  default     = {}
}
