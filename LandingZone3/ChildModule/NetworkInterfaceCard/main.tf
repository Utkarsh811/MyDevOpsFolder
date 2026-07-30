variable "nic-map" {
  
}

data "azurerm_public_ip" "publicip-datablock" {

  for_each = var.nic-map

  name                = each.value.nic-publicipname
  resource_group_name = each.value.rg
  
}


data "azurerm_subnet" "subnet-datablock" {

  for_each = var.nic-map


  name                 = each.value.nic-subnetname
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
  
}

resource "azurerm_network_interface" "nic-block" {

  for_each = var.nic-map
  name                = each.key
  location            = each.value.loc
  resource_group_name = each.value.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet-datablock[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.publicip-datablock[each.key].id
  
  
}
}