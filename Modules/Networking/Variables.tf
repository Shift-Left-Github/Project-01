variable "vnet_name" {
    type = string
    description = "Virtual Network Name"
}

variable "location" {
    type = string
    description = "Virtual Network Location"
}

variable "RSG_Name" {
    type = string

}

variable "Vnet_Range" {
    type = list

}

variable "DNS_Range" {
    type = list

}

/*
variable "Subnet_Name" {
  type = string
}

variable "Subnet_Range" {
    type = list
    description = "(optional) describe your variable"
}

variable "source_address_prefix" {
    type = string
    description = "(optional) describe your variable"
}

variable "destination_address_prefix" {
    type = string
    description = "(optional) describe your variable"
}

*/