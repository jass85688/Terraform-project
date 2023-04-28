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
resource "azurerm_subnet" "frontend-subnet" {
  name                 = "frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = var.az-resource-group
  virtual_network_name = azurerm_virtual_network.project_vnet.name
}

// subnet 2 for backend
resource "azurerm_subnet" "backend-subnet" {
  name                 = "backend-subnet"
  address_prefixes     = ["10.0.2.0/24"]
  resource_group_name  = var.az-resource-group
  virtual_network_name = azurerm_virtual_network.project_vnet.name
}

# This block connects a subnet to a network security group
resource "azurerm_subnet_network_security_group_association" "subnet1_nsg_association" {
  subnet_id                 = azurerm_subnet.frontend-subnet.id
  network_security_group_id = azurerm_network_security_group.project-security-group.id
}

resource "azurerm_subnet_network_security_group_association" "subnet3_nsg_association" {
  subnet_id                 = azurerm_subnet.backend-subnet.id
  network_security_group_id = azurerm_network_security_group.project-security-group.id
}

// To create a public ip for network interface
resource "azurerm_public_ip" "project-public-ip-nic" {
  name                = "project-public-ip-nic"
  location            = var.location
  resource_group_name = var.az-resource-group
  allocation_method   = "Static"
}

# To create a public ip for load balancer
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

# To create backend address pool to route request to backend server
resource "azurerm_lb_backend_address_pool" "project-backend-pool" {
  loadbalancer_id = azurerm_lb.project-lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "association1" {
  network_interface_id    = azurerm_network_interface.project-nic-1.id
  ip_configuration_name   = "project-ipconfig-1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.project-backend-pool.id

}

resource "azurerm_network_interface_backend_address_pool_association" "association2" {
  network_interface_id    = azurerm_network_interface.project-nic-2.id
  ip_configuration_name   = "project-ipconfig-2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.project-backend-pool.id

}

//The load balancer rule block creates "project-lb" that connects the frontend IP configuration and backend address pool.



resource "azurerm_lb_rule" "project-lb-rule" {
  loadbalancer_id                = azurerm_lb.project-lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "project-frontend-ip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.project-backend-pool.id]
  probe_id                       = azurerm_lb_probe.project-probe.id
}

resource "azurerm_lb_probe" "project-probe" {
  loadbalancer_id = azurerm_lb.project-lb.id
  name            = "ssh-running-probe"
  port            = 22
}

//Storage account
resource "azurerm_storage_account" "project-storage-acc" {
  name                     = var.storage-account-name
  location                 = var.location
  resource_group_name      = var.az-resource-group
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

// virtual machine

resource "azurerm_virtual_machine" "project-vm" {
  name                         = "project-vm"
  location                     = var.location
  resource_group_name          = var.az-resource-group
  network_interface_ids        = [azurerm_network_interface.project-nic-1.id, azurerm_network_interface.project-nic-2.id]
  vm_size                      = "Standard_D2s_v3"
  primary_network_interface_id = azurerm_network_interface.project-nic-1.id


  storage_data_disk {
    name            = azurerm_managed_disk.project-managed-disk.name
    managed_disk_id = azurerm_managed_disk.project-managed-disk.id
    create_option   = "Attach"
    lun             = 1
    disk_size_gb    = azurerm_managed_disk.project-managed-disk.disk_size_gb
  }

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
  availability_set_id = azurerm_availability_set.project-vm-as.id
}


