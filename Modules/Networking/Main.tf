
resource "azurerm_virtual_network" "Network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.RSG_Name
  address_space       = var.Vnet_Range

}
resource "azurerm_subnet" "subnet01" {
  name                 = var.Subnet_Name
  resource_group_name  = var.RSG_Name
  virtual_network_name = azurerm_virtual_network.Network.name
  address_prefixes     = [var.subnet_address_prefix]
  service_endpoints = ["Microsoft.AzureActiveDirectory","Microsoft.AzureActiveDirectory", "Microsoft.Storage",  ]
}
resource "azurerm_subnet" "BastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.RSG_Name
  virtual_network_name = azurerm_virtual_network.Network.name
  address_prefixes     = [var.subnet_address_prefix_bastion]
}

resource "azurerm_route_table" "rt01" {
  name                          = var.route01
  location                      = var.location
  resource_group_name           = var.RSG_Name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    next_hop_type  = "VirtualAppliance"
    address_prefix = "0.0.0.0/0"
    next_hop_in_ip_address = azurerm_firewall.fw01.ip_configuration[0].private_ip_address
  }

  tags = {
    environment = "Development"
  }
}

resource "azurerm_virtual_network_dns_servers" "dns01" {
  virtual_network_id = azurerm_virtual_network.Network.id
  dns_servers        = [azurerm_firewall.fw01.ip_configuration[0].private_ip_address]
}

resource "azurerm_public_ip" "BastionIP" {
  name                = "bastion-publicip"
  location            = var.location
  resource_group_name = var.RSG_Name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "Bastion01" {
  name                = "Bastion-01"
  location            = var.location
  resource_group_name = var.RSG_Name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.BastionSubnet.id
    public_ip_address_id = azurerm_public_ip.BastionIP.id
  }
}
## FW
resource "azurerm_firewall" "fw01" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.RSG_Name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id = azurerm_firewall_policy.Policy01.id
  //firewall_policy_id = var.FW_Policy

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.FW_Subnet.id
    public_ip_address_id = azurerm_public_ip.Public_IP.id
  }
}
resource "azurerm_subnet" "FW_Subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.RSG_Name
  virtual_network_name = azurerm_virtual_network.Network.name
  address_prefixes     =  [var.FW_Subnet_address_prefix]
}

resource "azurerm_public_ip" "Public_IP" {
  name                = lower("${var.RSG_Name}publicip")
  location            = var.location
  resource_group_name = var.RSG_Name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_firewall_policy" "Policy01" {
  name                = "${var.RSG_Name}-Policy-01"
  resource_group_name =var.RSG_Name
  location            = var.location
  
  dns {
    proxy_enabled = true
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