variable "name" {
  description = "Virtual network name. Example: vnet-hub-network-001."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that owns the VNet."
  type        = string
}

variable "address_space" {
  description = "List of CIDR ranges for the VNet."
  type        = list(string)
  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one VNet address space is required."
  }
}

variable "dns_servers" {
  description = "Optional custom DNS servers."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default     = {}
}
