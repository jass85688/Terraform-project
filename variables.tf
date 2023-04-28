# variable for resource group name
variable "az-resource-group" {
  type    = string
  default = "1-d3fe58fe-playground-sandbox"
}

# variable for location
variable "location" {
  type    = string
  default = "South Central US"
}

# variable for availability set name
variable "availability-set" {
  type    = string
  default = "project-vm-as"
}

# variable for storage account name
variable "storage-account-name" {
  type    = string
  default = "projectstorageacc199601"
}
