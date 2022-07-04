resource "azurerm_windows_virtual_machine" "VM1" {
  name                = var.VM_name
  resource_group_name = var.RSG_Name
  location            = var.location
  size                = var.Size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
 timezone= "Eastern Standard Time"
  allow_extension_operations = true
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_network_interface" "nic1" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.RSG_Name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}