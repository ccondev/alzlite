terraform {
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = ">=2.94.0"
      
    }
  }
}

provider "azurerm" {

  subscription_id = ""
  tenant_id       = ""
  features {}
}
