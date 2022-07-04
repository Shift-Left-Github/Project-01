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

resource "random_password" "password" {
  length           = 26
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# May need ${rsadecrypt(self.password\_data,file("/path/to/private\_key.pem"))} to decrypt RSA keys to base64 - Maninly Linux