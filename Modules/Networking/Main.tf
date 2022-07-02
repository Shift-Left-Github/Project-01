
/*
resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
} */

terraform {
  required_version = ">=0.12"
}

resource "azurerm_virtual_network" "Network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.RSG_Name
  address_space       = var.Vnet_Range
  dns_servers         = var.DNS_Range

}
/*
resource "azurerm_subnet" "example" {
  name                 = var.Subnet_Name
  resource_group_name  = var.RSG_Name
  virtual_network_name = azurerm_virtual_network.Network.name
  address_prefixes     = var.Subnet_Range
  service_endpoints = ["Microsoft.Storage","Microsoft.KeyVault", "Microsoft.AzureActiveDirectory", ]


}
*/
/*
resource "azurerm_network_security_group" "NSG1" {
  name                = "nsg1"
  location            = var.location
  resource_group_name = var.RSG_Name

  security_rule {
    name                       = "rdp-from-home"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = var.destination_address_prefix
  }

  tags = {
    environment = "Development"
  }
}


resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.NSG1.id
}
*/