variable "subnet-map" {
  
}



resource "azurerm_subnet" "subnet-block" {

    for_each = var.subnet-map
        
  name                 = each.key
  resource_group_name  = each.value.rg
  virtual_network_name = each.value.vnet
  address_prefixes     = each.value.ap

  
}