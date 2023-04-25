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
#  resource "azurerm_network_security_group" "project-security-group" {
#    name                = "project-security-group"
#   location            = var.location
#   resource_group_name = var.az-resource-group
#  }

//interface
resource "azurerm_network_interface" "project-interface1" {
  name                = "project-interface1"
  location            = var.location
  resource_group_name = var.az-resource-group

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurem_subnet.frontend-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

// storage account container
resource "azurerm_storage_container" "vm-managed-disks-container" {
  name                  = "vm-managed-disks-container"
  storage_account_name  = azurerm_storage_account.project-storage-acc.name
  container_access_type = "private"
}

//network interface card
# resource "azurerm_network_interface" "nic" {
#   count               = 1
#   name                = "my-nic-${count.index + 1}"
#   location            = var.location
#   resource_group_name = var.az-resource-group

#   ip_configuration {
#     name                          = "my-nic-ipconfig"
#     subnet_id                     =  azurem_virtual_network.project_vnet.frontend-subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.project-public-ip.id
#   }

#   network_security_group_id = azurerm_network_security_group.project-security-group.id
# }