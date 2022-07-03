output "VNET" {
  value = azurerm_virtual_network.Network
}
output "RTTable01" {
  value = azurerm_route_table.rt01
}
output "FW" {
  value = azurerm_firewall.fw01
}
/*
output "SubnetOutput" {
  value = azurerm_subnet.example
  description = "Export the subnet for the associated resource"
}
*/