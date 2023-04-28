//availability set
resource "azurerm_availability_set" "project-vm-as" {
  name                = var.availability-set
  location            = var.location
  resource_group_name = var.az-resource-group
  managed             = true
  # platform_fault_domain_count = 2
  # platform_update_domain_count = 2
}

//Network security group 
resource "azurerm_network_security_group" "project-security-group" {
  name                = "project-security-group"
  location            = var.location
  resource_group_name = var.az-resource-group
}



// storage account container for virtual machine
resource "azurerm_storage_container" "vm-managed-disks-container" {
  name                  = "vm-managed-disks-container"
  storage_account_name  = var.storage-account-name
  container_access_type = "private"
}

// storage account container for backend
resource "azurerm_storage_container" "backend-container" {
  name                  = "backend-container"
  storage_account_name  = var.storage-account-name
  container_access_type = "private"
}

//network interface card
resource "azurerm_network_interface" "project-nic-1" {
  # count               = 2
  name                = "project-nic-1"
  location            = var.location
  resource_group_name = var.az-resource-group

  ip_configuration {
    name                          = "project-ipconfig-1"
    subnet_id                     = azurerm_subnet.frontend-subnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true

  }




  # network_security_group_id = azurerm_network_security_group.project-security-group.id
}

resource "azurerm_network_interface" "project-nic-2" {
  name                = "project-nic-2"
  location            = var.location
  resource_group_name = var.az-resource-group

  ip_configuration {
    name                          = "project-ipconfig-2"
    subnet_id                     = azurerm_subnet.backend-subnet.id
    private_ip_address_allocation = "Dynamic"

  }




  # network_security_group_id = azurerm_network_security_group.project-security-group.id
}
resource "azurerm_managed_disk" "project-managed-disk" {

  name                 = "project-managed-disk"
  location             = var.location
  resource_group_name  = var.az-resource-group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1023"
}