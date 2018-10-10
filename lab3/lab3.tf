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

#Exerice 1
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

#Exericse 2
/*
resource "azurerm_app_service" "asp-webapp" {
  
}
*/

#Exercise 3
/*
resource "azurerm_app_service_slot" "asp-webapp" {

}
*/

#Exercise 4
/*
resource "azurerm_sql_server" "server" {

}
*/

#Exercise 4
/*
resource "azurerm_sql_database" "db" {
  
}
*/

/* #Exerice 3
output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.asp-webapp.default_site_hostname}"
}
*/

/* #Exercise 4
output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  value       = "Server=tcp:${azurerm_sql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db.name};Persist Security Info=False;User ID=${azurerm_sql_server.server.administrator_login};Password=${azurerm_sql_server.server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
*/

