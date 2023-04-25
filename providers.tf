terraform {
   required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.42.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
  features {
    
  }
  # skip_provider_registration = true
}

