# variable "aws_usernames" {
#   type = list(string)
#   default = ["Jaspal","Harsimran","Jaldeep","Afsah"]
# }

variable "az-resource-group" {
  type    = string
  default = "1-8400d1ca-playground-sandbox"
}

variable "location" {
  type    = string
  default = "East US"
}

# variable "subnet1-id" {
#   default = azurerm_virtual_network.project_vnet.frontend-subnet.id
# }
# variable "s3_bucket_names" {
#   type = list
#   default = ["bucket1.app", "bucket2.app"]
# }

# variable "prefix" {
#   default = "jass1234"
# }

# variable "storage_acc_name" {
#   type = string
#   default = "jaspalstorageacc1"
# }