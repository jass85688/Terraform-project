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
  subscription_id = "80ea84e8-afce-4851-928a-9e2219724c69"
  features {

  }
  skip_provider_registration = true
}

