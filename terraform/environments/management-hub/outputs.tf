output "management_resource_group_name" { value = module.management_rg.name }
output "log_analytics_workspace_id" { value = module.log_analytics.id }
output "key_vault_uri" { value = module.key_vault.uri }
