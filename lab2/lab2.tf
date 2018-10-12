# Configure the Microsoft Azure Provider (from Lab1)

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  environment     = "${var.environment}"
}

#Exercise 1
/*
resource "azurerm_virtual_network" "vnet" {
  

}

resource "azurerm_subnet" "vnetsub" {
  


}
*/

#Exercise 2
/*
resource "azurerm_public_ip" "winIP" {
 

}
*/

#Exercise 3
/*
resource "azurerm_network_interface" "winnic" {
  

  ip_configuration {
    

  }
}
*/

#Exercise 4
/*
resource "azurerm_virtual_machine" "winvm" {



  storage_image_reference {
  
  }

  storage_os_disk {

  }

  os_profile {
    computer_name  = "WinServer"
    admin_username = "winadmin"
    admin_password = "Pass@word01"
  }

  os_profile_windows_config = {
    
  }
}
*/