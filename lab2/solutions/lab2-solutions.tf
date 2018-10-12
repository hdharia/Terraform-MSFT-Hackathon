# Configure the Microsoft Azure Provider (from Lab1)

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  environment     = "${var.environment}"
}

#Exercise 1
resource "azurerm_virtual_network" "vnet" {
  name                = "${format("%s-vnet", var.StudentID)}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"
}

resource "azurerm_subnet" "vnetsub" {
  name                 = "${format("%s-subnet", var.StudentID)}"
  resource_group_name  = "${var.rgname}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.0.1.0/24"
}

#Exercise 2
resource "azurerm_public_ip" "winIP" {
  name                         = "${format("%s-winIP", var.StudentID)}"
  location                     = "${var.location}"
  resource_group_name          = "${var.rgname}"
  public_ip_address_allocation = "dynamic"
}

#Exercise 3
resource "azurerm_network_interface" "winnic" {
  name                = "${format("%s-winnic", var.StudentID)}"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"

  ip_configuration {
    name                          = "${format("%s-ipconfig", var.StudentID)}"
    subnet_id                     = "${azurerm_subnet.vnetsub.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.winIP.id}"
  }
}

#Exercise 4
resource "azurerm_virtual_machine" "winvm" {
  name                             = "${format("%s-winVM", var.StudentID)}"
  location                         = "${var.location}"
  resource_group_name              = "${var.rgname}"
  network_interface_ids            = ["${azurerm_network_interface.winnic.id}"]
  vm_size                          = "Standard_DS2_V2"
  delete_os_disk_on_termination    = "true"
  delete_data_disks_on_termination = "true"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${format("%s-osdisk", var.StudentID)}"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
    os_type           = "Windows"
  }

  os_profile {
    computer_name  = "WinServer"
    admin_username = "winadmin"
    admin_password = "Pass@word01"
  }

  os_profile_windows_config = {
    provision_vm_agent = "true"
  }
}