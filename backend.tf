terraform {
  backend "azurerm" {
    resource_group_name  = "1-d3fe58fe-playground-sandbox"
    storage_account_name = "projectstorageacc199601"
    container_name       = "backend-container"
    key                  = "path/terraform.tfstate"
  }
}
