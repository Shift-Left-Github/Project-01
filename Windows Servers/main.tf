resource "azurerm_resource_group" "RSG" {
  name     = var.RSG_Name
  location = var.location["east"]
}

module "Net_01" {
  source     = "../Modules/Networking/" # Referencing the network module
  vnet_name  = "${var.RSG_Name}-Net-192.170.0.0_16"
  location   = azurerm_resource_group.RSG.location # May delete this and leverage the default module value.
  RSG_Name   = azurerm_resource_group.RSG.name
  Vnet_Range = ["192.170.0.0/16"]
  DNS_Range  = ["1.1.1.2", "1.1.1.1"]
  route01        = "route01"
  FW_Subnet_address_prefix = "192.170.2.0/24"
  fw_name = "EUS-Development-FW-01"
}
module "Sub_01" {
  source               = "../Modules/Networking/Subnets/"
  Subnet_Name          = lower("${var.RSG_Name}-sub1-192.170.1.0_24")
  resource_group_name  = azurerm_resource_group.RSG.name
  virtual_network_name = module.Net_01.VNET.name
  address_prefix       = "192.170.1.0/24"

}

module "VM1" {
  source         = "../Modules/VM/"
  count          = 2 #Will create two machines
  RSG_Name       = azurerm_resource_group.RSG.name
  location       = azurerm_resource_group.RSG.location
  VM_name        = "${var.computername}-${count.index}"
  Size           = "Standard_F2"
  admin_username = "azure-${count.index}"
  admin_password = var.admin_password #8-123 characters
  subnet_id      = module.Sub_01.SubnetOutput.id
  nic_name       = lower("${var.RSG_Name}-${count.index}")

}
# Associate the subnet with the route table.
resource "azurerm_subnet_route_table_association" "rtassociation" {
  subnet_id      = module.Sub_01.SubnetOutput.id
  route_table_id = module.Net_01.RTTable01.id
}
### Building extentions into the VMS via the extentions module

/*
module "ADDLogin" {
  source = "../Modules/Extentions/"
  virtual_machine_id = module.VM1.AADEx.id
}
*/

# Will add this to its own module.
/*
resource "azurerm_storage_account" "strg" {
  name                     = "omnicellavdstrg01"
  resource_group_name      = azurerm_resource_group.RSG.name
  location                 = azurerm_resource_group.RSG.location
  account_tier             = "Premium"
  account_replication_type = "GRS"
  min_tls_version = "TLS1_2"

  tags = {
    environment = "staging"
  }
}
*/