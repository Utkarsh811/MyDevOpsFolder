resource "azurerm_storage_account" "stg-block" {

    for_each = var.map-storageacc

    name = each.key
    location = each.value.loc
    resource_group_name = each.value.rg
    account_tier = each.value.at
    account_replication_type = each.value.art

  tags = {
    environment = "staging"
  }
  
}