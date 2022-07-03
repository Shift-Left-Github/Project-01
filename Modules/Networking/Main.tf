
resource "azurerm_virtual_network" "Network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.RSG_Name
  address_space       = var.Vnet_Range
  dns_servers         = var.DNS_Range  #Need to add the private IP of the firewall here. "azurerm_firewall.fw01.ip_configuration[0].private_ip_address"

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
    environment = "Development"
  }
}
resource "azurerm_subnet" "FW_Subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.RSG_Name
  virtual_network_name = azurerm_virtual_network.Network.name
  address_prefixes     =  [var.FW_Subnet_address_prefix]
}

resource "azurerm_public_ip" "Public_IP" {
  name                = "testpip"
  location            = var.location
  resource_group_name = var.RSG_Name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw01" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.RSG_Name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.FW_Subnet.id
    public_ip_address_id = azurerm_public_ip.Public_IP.id
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