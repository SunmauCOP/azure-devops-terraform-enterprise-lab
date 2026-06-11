output "network_resource_group_name" { value = module.network_rg.name }
output "hub_vnet_id" { value = module.hub_vnet.id }
output "hub_subnet_ids" { value = { for key, subnet in module.hub_subnets : key => subnet.id } }
