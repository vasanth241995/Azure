# data "azurerm_container_registry" "prod_container_registry" {
#   name                = var.prod_container_registry_name
#   resource_group_name = var.common_resource_group
# }

# data "azurerm_signalr_service" "signalr" {
#   name                = module.create_signalr.signalr_name
#   resource_group_name = var.resource_group
# }