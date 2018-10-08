# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  environment     = "${var.environment}"
}

resource "azurerm_resource_group" "lab1" {
  name     = "myTFRG"
  location = "eastus"

  tags = {
    environment = "Development"
  }
}



