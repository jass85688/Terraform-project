terraform {
  backend "azurerm" {
    resource_group_name   = "1-2b8c0be9-playground-sandbox"
    storage_account_name  = "projectstorageacc199601"
    container_name        = "backend-container"
    key                   = "path/terraform.tfstate"
  }
}