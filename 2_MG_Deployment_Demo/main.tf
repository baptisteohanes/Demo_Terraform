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
  subscription_id = var.SUBID_DEVOPS
}

variable "SUBID_DEVOPS" {
  type = string
}

data "azurerm_management_group" "parent_management_group" {
  name = "BaptisteOhanesMG"
}

output "display_name" {
  value = data.azurerm_management_group.parent_management_group.display_name
}

resource "azurerm_management_group" "child_management_group" {
  display_name               = "ChildGroupDemo"
  parent_management_group_id = data.azurerm_management_group.parent_management_group.id
}

resource "azurerm_management_group_policy_assignment" "PolicyAssignment" {
  name                 = "NoPublicIP"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"
  management_group_id  = azurerm_management_group.child_management_group.id
}