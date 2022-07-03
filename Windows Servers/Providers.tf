data "azurerm_subscription" "current" {
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}
provider "azurerm" {
  // skip_provider_registration = true
  features {}
}