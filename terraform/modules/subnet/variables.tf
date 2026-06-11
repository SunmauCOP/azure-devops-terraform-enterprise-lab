variable "name" {
  description = "Subnet name."
  type        = string
}

variable "resource_group_name" {
  description = "VNet resource group."
  type        = string
}

variable "virtual_network_name" {
  description = "Parent VNet name."
  type        = string
}

variable "address_prefixes" {
  description = "Subnet CIDR ranges."
  type        = list(string)
}

variable "service_endpoints" {
  description = "Optional service endpoints."
  type        = list(string)
  default     = []
}

variable "network_security_group_id" {
  description = "Optional NSG association."
  type        = string
  default     = null
}

variable "route_table_id" {
  description = "Optional route table association."
  type        = string
  default     = null
}
variable "delegations" {
  description = "Optional subnet delegations, for example Microsoft.Web/serverFarms."
  type = list(object({
    name         = string
    service_name = string
    actions      = list(string)
  }))
  default = []
}
