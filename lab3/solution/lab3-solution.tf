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

  depends_on = ["azurerm_sql_database.db"]
}

resource "azurerm_app_service" "asp-webapp" {
  name                = "asp-webapp-webapp"
  location            = "${azurerm_resource_group.asp-webapp.location}"
  resource_group_name = "${azurerm_resource_group.asp-webapp.name}"
  app_service_plan_id = "${azurerm_app_service_plan.asp-webapp.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    php_version = "7.1"
    default_documents = ["hostingstart.html"]
  }

  depends_on = ["azurerm_sql_database.db"]
}

resource "azurerm_app_service_slot" "asp-webapp" {

  name                = "dev"
  app_service_name    = "${azurerm_app_service.asp-webapp.name}"
  location            = "${azurerm_resource_group.asp-webapp.location}"
  resource_group_name = "${azurerm_resource_group.asp-webapp.name}"
  app_service_plan_id = "${azurerm_app_service_plan.asp-webapp.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    php_version = "7.1"
    default_documents = ["hostingstart.html"]
  }

  connection_string {
    name = "Database"
    type = "SQLAzure"
    value = "Server=tcp:${azurerm_sql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db.name};Persist Security Info=False;User ID=${azurerm_sql_server.server.administrator_login};Password=${azurerm_sql_server.server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  depends_on = ["azurerm_sql_database.db"]
}

resource "azurerm_sql_server" "server" {
    name = "hd-sqlserver"
    resource_group_name = "${azurerm_resource_group.asp-webapp.name}"
    location = "East US"
    version = "12.0"
    administrator_login = "terraform-db"
    administrator_login_password = "Pas5w0wrd123!4"
}

resource "azurerm_sql_database" "db" {
  name                = "hd-sqldatabase"
  resource_group_name = "${azurerm_resource_group.asp-webapp.name}"
    location = "East US"
    server_name = "${azurerm_sql_server.server.name}"

  tags {
    environment = "production"
  }
}

output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.asp-webapp.default_site_hostname}"
}

output "app_service_dev_default_hostname" {
  value = "https://${azurerm_app_service_slot.asp-webapp.default_site_hostname}"
}

output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  value       = "Server=tcp:${azurerm_sql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db.name};Persist Security Info=False;User ID=${azurerm_sql_server.server.administrator_login};Password=${azurerm_sql_server.server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}


