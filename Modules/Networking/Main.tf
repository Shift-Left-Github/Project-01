
resource "azurerm_virtual_network" "Network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.RSG_Name
  address_space       = var.Vnet_Range
  dns_servers         = var.DNS_Range

}
resource "azurerm_route_table" "rt01" {
  name                          = var.route01
  location                      = var.location
  resource_group_name           = var.RSG_Name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VnetLocal"
  }

  tags = {
    environment = "Production"
  }
}
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