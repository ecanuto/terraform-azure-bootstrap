terraform {
  required_version = "~> 1.8.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  ## Uncomment after first 'apply'
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "tfstate0st"
  #   container_name       = "tfstate"
  #   key                  = "dutlabs-azure-iac-bootstrap.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# NetworkWatcher
resource "azurerm_resource_group" "watcher" {
  name     = "networkwatcher-rg"
  location = "East US"
}

resource "azurerm_network_watcher" "watcher" {
  name                = "networkwatcher"
  location            = azurerm_resource_group.watcher.location
  resource_group_name = azurerm_resource_group.watcher.name
}

# State
resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-rg"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "tfstate0st"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
