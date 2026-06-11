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
  description = "Short lowercase prefix."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
}

variable "hub_address_space" {
  description = "Hub VNet address space."
  type        = list(string)
}

variable "subnets" {
  description = "Map of hub subnet definitions."
  type = map(object({
    address_prefixes = list(string)
  }))
}
