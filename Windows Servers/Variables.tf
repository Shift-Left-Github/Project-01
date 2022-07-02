# Some feilds are required for Terrafom Cloud deployments.
/*
variable "Subscription" {
    type = map(string)

}

variable "tenant_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "client_id" {
  type = string
}

*/
variable "RSG_Name" {
  default = "AVD-EUS2-Development"
  type = string
}
variable "computername" { #Computer name has to be under 15 characters
  default = "Desktop"
  type = string
}

variable "admin_password" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "location" {
  type = map(string)
  default = {
    east = "eastus2"
    west = "westus2"
    central = "centralus"
  }
}