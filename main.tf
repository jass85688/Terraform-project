// Resource group
# resource "azurerm_resource_group" "terraform-project" {
#   name     = "terraform-project-resource-group"
#   location = "eastus"
# }



//Virtual network
resource "azurerm_virtual_network" "project_vnet" {
  name                = "project_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.az-resource-group

}
// subnet 1 for frontend
  resource "azurem_subnet" "frontend-subnet" {
    name           = "frontend-subnet"
    address_prefix = "10.0.1.0/24"
    resource_group_name = var.az-resource-group
    virtual_network_name = azurem_virtual_network.project_vnet.name
  }

// subnet 2 for backend
#   subnet {
#     name           = "backend-subnet"
#     address_prefix = "10.0.2.0/24"
#   }

# // subnet 3 for middle
#   subnet {
#     name           = "middle-subnet"
#     address_prefix = "10.0.3.0/24"
#   }

// public ip
resource "azurerm_public_ip" "project-public-ip" {
  name                = "project-public-ip"
  location            = var.location
  resource_group_name = var.az-resource-group
  allocation_method   = "Static"
}

// load balancer
resource "azurerm_lb" "project-lb" {
  name                = "project-lb"
  location            = var.location
  resource_group_name = var.az-resource-group

  frontend_ip_configuration {
    name                          = "project-frontend-ip"
    public_ip_address_id          = azurerm_public_ip.project-public-ip.id
    private_ip_address_allocation = "Dynamic"
  }

  
}

//The load balancer rule block creates a new rule named "example-rule" that connects the frontend IP configuration and backend address pool to port 80 using TCP.

# resource "azurerm_lb_rule" "example" {
#   name                   = "project-lb-rule"
#   protocol               = "Tcp"
#   # frontend_ip_configuration_id = azurerm_lb.project-lb.project-frontend-ip.id
# #   backend_address_pool_id       = azurerm_lb.project-lb.backend_address_pool[0].id
#   frontend_port          = 80
#   backend_port           = 80
# }

//Storage account
resource "azurerm_storage_account" "project-storage-acc" {
  name                     = "projectstorageacc1996"
  location            = var.location
  resource_group_name = var.az-resource-group
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}


// virtual machine

resource "azurerm_virtual_machine" "project-vm" {
  name                  = "project-vm"
  location            = var.location
  resource_group_name = var.az-resource-group
  network_interface_ids = [azurerm_network_interface.project-interface1.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}


