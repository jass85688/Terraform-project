terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42.0"
    }
  }
}



provider "azurerm" {
  # Configuration options
  subscription_id = "0cfe2870-d256-4119-b0a3-16293ac11bdc"
  features {

  }
  skip_provider_registration = true
}

