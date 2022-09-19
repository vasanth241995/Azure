resource "azurerm_application_insights" "appinsights" {
  name                = var.appinsights_name
  location            = var.location
  resource_group_name = var.resource_group
  application_type    = "web"
  retention_in_days   = 90
  tags = {
    Environment = var.environment
    Creator     = var.creator
  }
}