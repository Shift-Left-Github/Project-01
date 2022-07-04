variable "vnet_name" {
    type = string
    default = "value"
    description = "Virtual Network Name"
}

variable "location" {
    type = string
    default = "eastus2"
    description = "Virtual Network Location"
}

variable "RSG_Name" {
    type = string

}

variable "Vnet_Range" {
    type = list
    
}

variable "route01" {
    type = string
    //default = "0"
    description = "(optional) describe your variable"
}
variable "FW_Subnet_address_prefix" {
    type = string
    description = "(optional) describe your variable"
}
variable "fw_name" {
    type = string
    description = "(optional) describe your variable"
}
variable "Subnet_Name" {
  type = string
}
variable "subnet_address_prefix" {
  type = string
}
