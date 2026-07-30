module "rg-module" {

  source = "../../ChildModule/ResourceGroups"
  rg-map = var.rg_map


}

module "storageacc-module" {

  depends_on = [module.rg-module]

  source         = "../../ChildModule/StorageAccount"
  map-storageacc = var.map_storageacc

}


module "vnet-module" {
  depends_on = [module.rg-module]

  source   = "../../ChildModule/VirtualNetworks"
  vnet-map = var.map_vnet-map

}

module "subnet-module" {
  depends_on = [module.vnet-module]
  source     = "../../ChildModule/Subnets"

  subnet-map = var.map-subnet
}

module "publicip-module" {
  depends_on   = [module.rg-module]
  source       = "../../ChildModule/PublicIps"
  publicip-map = var.map-publicip

}

module "nic-module" {
  depends_on = [module.subnet-module, module.publicip-module]
  source     = "../../ChildModule/NetworkInterfaceCard"
  nic-map    = var.map-nic

}

module "vm-module" {
  depends_on  = [module.nic-module]
  source      = "../../ChildModule/VirtualMachines"
  machine-map = var.map-machine

}
