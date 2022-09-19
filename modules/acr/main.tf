resource "azurerm_container_registry" "acr" {
  name                     = var.registry_name
  resource_group_name      = var.resource_group
  location                 = var.location
  sku                      = "Standard"
  admin_enabled            = false
  tags = {
    Environment = var.environment
  }

}
