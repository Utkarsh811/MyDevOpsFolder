variable "machine-map" {
  
}


data "azurerm_network_interface" "nic-datablock" {
    for_each = var.machine-map
  name                = each.value.nic_name
  resource_group_name = each.value.vm_rg

  
}
resource "azurerm_virtual_machine" "vm-block" {
for_each = var.machine-map

name                  = each.key
  location              = each.value.vm_loc
  resource_group_name   = each.value.vm_rg
  vm_size               = each.value.vm_size

  network_interface_ids = [data.azurerm_network_interface.nic-datablock[each.key].id]



  storage_image_reference {
    publisher = "Canonical"
    offer     = each.value.offer
    sku       = each.value.sku
    version   = "latest"
  }
  storage_os_disk {
    name              = each.value.osdisk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.username
    admin_password = each.value.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}