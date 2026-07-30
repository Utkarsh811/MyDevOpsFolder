variable "publicip-map" {
  
}


resource "azurerm_public_ip" "publicip-block" {

    for_each = var.publicip-map

  name                = each.key
  resource_group_name = each.value.rg
  location            = each.value.loc
  allocation_method   = each.value.am
  
}