# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  environment     = "${var.environment}"
}

resource "azurerm_resource_group" "asp-webapp"
{
  name = "<Update Resource Group>"
  location = "eastus"
}

resource "azurerm_app_service_plan" "asp-webapp"
{
  name = "asp-webapp-plan"
  resource_group_name = "${azurerm_resource_group.asp-webapp.name}"
  location = "${azurerm_resource_group.asp-webapp.location}"

  sku
  {
    tier = "Basic"
    size = "B1"
  }
}

/*
resource "azurerm_app_service" "asp-webapp" {
  
}
*/

/*
resource "azurerm_app_service_slot" "asp-webapp" {

}
*/

/*
output "app_service_default_hostname" {
  
}
*/

/*
output "app_service_dev_default_hostname" {
  
}
*/

