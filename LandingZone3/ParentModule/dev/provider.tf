terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "myrg1"
    storage_account_name = "mystaterfile"
    container_name       = "myblb1"
    key                  = "prostate.terraform.tfstate"



  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}