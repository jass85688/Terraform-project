//availability set
resource "azurerm_availability_set" "project-vm-as" {
  name                = "project-vm-as"
  location            = var.location
  resource_group_name = var.az-resource-group
  managed             = true
  #   platform_fault_domain_count = 2
  #   platform_update_domain_count = 2
}

//Network security group (optional)
resource "azurerm_network_security_group" "project-security-group" {
  name                = "project-security-group"
  location            = var.location
  resource_group_name = var.az-resource-group
}



// storage account container for virtual machine
resource "azurerm_storage_container" "vm-managed-disks-container" {
  name                  = "vm-managed-disks-container"
  storage_account_name  = azurerm_storage_account.project-storage-acc.name
  container_access_type = "private"
}

// storage account container for backend
resource "azurerm_storage_container" "backend-container" {
  name                  = "backend-container"
  storage_account_name  = azurerm_storage_account.project-storage-acc.name
  container_access_type = "private"
}

//network interface card
resource "azurerm_network_interface" "project-nic" {
  count               = 3
  name                = "project-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.az-resource-group

  ip_configuration {
    name                          = "nic-ip-config-${count.index}"
    subnet_id                     = element([azurerm_subnet.frontend-subnet.id, azurerm_subnet.middle-subnet.id, azurerm_subnet.backend-subnet.id], count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.project-public-ip.id
  }

  # network_security_group_id = azurerm_network_security_group.project-security-group.id
}