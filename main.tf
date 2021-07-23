# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "jagdevtfstate"
    container_name       = "store"
    key                  = "sandboxdeployment.tfstate"
    use_azuread_auth     = true
    subscription_id      = "6ca4b754-00c0-45aa-a458-bf5f7d2f168b"
    tenant_id            = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  }
}

variable "SUBID" {
  type=string
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.SUBID
}

# Create a resource group
resource "azurerm_resource_group" "examplerg" {
  name     = "rg-sbx-terraformdemo"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "examplevnrt" {
  name                = "vnet-sbx-terraformdemo"
  resource_group_name = azurerm_resource_group.examplerg.name
  location            = azurerm_resource_group.examplerg.location
  address_space       = ["10.0.0.0/16"]
}
