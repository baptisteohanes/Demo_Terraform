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
    resource_group_name  = "rg-dev-ci"
    storage_account_name = "jagdevtfstate"
    container_name       = "store"
    key                  = "deployment.tfstate"
    access_key = var.ACCESSKEY
  }
}

variable "SUBID" {
  type=string
}

variable "ACCESSKEY" {
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
