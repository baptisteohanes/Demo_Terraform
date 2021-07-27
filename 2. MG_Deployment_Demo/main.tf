# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
#workflow trigger
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
    key                  = "MG_Deployment_Demo.tfstate"
    subscription_id      = "6ca4b754-00c0-45aa-a458-bf5f7d2f168b"
    tenant_id            = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_management_group" "parent_management_group" {
  name = "BaptisteOhanesMG"
}

resource "azurerm_management_group" "child_management_group" {
  display_name               = "ChildGroupDemo"
  parent_management_group_id = azurerm_management_group.parent_management_group.id
}