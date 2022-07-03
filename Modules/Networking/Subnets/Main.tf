resource "azurerm_subnet" "subnet01" {
  name                 = var.Subnet_Name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.address_prefix]
}





