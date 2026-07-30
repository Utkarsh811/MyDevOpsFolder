variable "vnet-map" {
  
}
resource "azurerm_virtual_network" "vnet-block" {

    for_each = var.vnet-map
    name = each.key
    location = each.value.loc
    resource_group_name = each.value.rg
    address_space  = each.value.as
  
}