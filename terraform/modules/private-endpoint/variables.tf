variable "name" {
  description = "Private endpoint name."
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

variable "subnet_id" {
  description = "Subnet ID for private endpoint."
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID being privately exposed."
  type        = string
}

variable "subresource_names" {
  description = "Subresource names, for example blob, vault, sites."
  type        = list(string)
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
