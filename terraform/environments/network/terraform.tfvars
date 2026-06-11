tenant_id                  = "7343d188-f98c-4793-97f3-e6ccd3787248"
management_subscription_id = "c6e7f0c7-4e26-460f-a38b-352ba770f183"
network_subscription_id    = "58b309b9-d522-49b7-bfa8-a9c3cbd7ee4c"
dev_subscription_id        = "58b309b9-d522-49b7-bfa8-a9c3cbd7ee4c"
prod_subscription_id       = "dcc52c0d-38d2-4363-866c-4362b23a20b2"
location                   = "eastus2"
environment                = "network"
naming_prefix              = "entlab"
hub_address_space          = ["10.10.0.0/16"]
subnets = {
  AzureFirewallSubnet = { address_prefixes = ["10.10.0.0/26"] }
  snet-shared-001     = { address_prefixes = ["10.10.1.0/24"] }
  snet-private-001    = { address_prefixes = ["10.10.2.0/24"] }
}
tags = {
  CostCenter  = "CloudPlatform"
  Owner       = "NetworkEngineering"
  DataClass   = "Internal"
  Criticality = "High"
}
