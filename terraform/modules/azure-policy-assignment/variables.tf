variable "name" {
  description = "Policy assignment name."
  type        = string
}

variable "display_name" {
  description = "Human-readable assignment name."
  type        = string
}

variable "description" {
  description = "Assignment description."
  type        = string
  default     = null
}

variable "scope_type" {
  description = "subscription or resource_group."
  type        = string
  default     = "subscription"
  validation {
    condition     = contains(["subscription", "resource_group"], var.scope_type)
    error_message = "scope_type must be subscription or resource_group."
  }
}

variable "scope_id" {
  description = "Subscription ID or resource group ID depending on scope_type."
  type        = string
}

variable "policy_definition_id" {
  description = "Policy definition resource ID."
  type        = string
}

variable "parameters_json" {
  description = "Policy parameters as JSON string."
  type        = string
  default     = null
}

variable "location" {
  description = "Required when assignment has managed identity."
  type        = string
  default     = null
}

variable "enable_managed_identity" {
  description = "Enable managed identity for deployIfNotExists policies."
  type        = bool
  default     = false
}
