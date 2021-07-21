# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.68.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "9701dbda-775c-4280-a733-50123184ed41"
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