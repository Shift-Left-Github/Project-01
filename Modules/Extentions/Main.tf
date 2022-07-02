
terraform {
  required_version = ">=0.12"
}

resource "azurerm_virtual_machine_extension" "example" {
  name                 = "Microsoft.Azure.Monitor"
  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorWindowsAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = "true"

  tags = {
    environment = "Development"
  }
}

resource "azurerm_virtual_machine_extension" "gc" {
  name                       = "AzurePolicyforWindows"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  tags = {
    environment = "Development"
  }
}
#This extention will cause issues when deployed on AVD machines. Azure should deploy this while adding machines to the host pool
resource "azurerm_virtual_machine_extension" "azlogin" { 
  name                       = "AADLoginForWindows"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  tags = {
    environment = "Development"
  }
}

/*
resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
} 
*/

/*
resource "azurerm_virtual_machine_extension" "vm1" {
  name                 = "S1-Test"
  virtual_machine_id   = azurerm_windows_virtual_machine.VM1.id
  publisher            = "SentinelOne.WindowsExtension"
  type                 = "WindowsExtension"
  type_handler_version = "1.0"

  settings = <<SETTINGS
    {
        "commandToExecute": "hostname && uptime"
    }
SETTINGS


  tags = {
    environment = "Production"
  }
}

*/
