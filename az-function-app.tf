# ###Add a storage account and container
# module "create_storage_account_azurefn" {
#   source                          = "./modules/storageaccount"
#   stroageaccount_name             = var.storage_account_name_azurefn
#   location                        = var.location_name
#   resource_group                  = var.resource_group
#   environment                     = var.environment
#   tier                            = var.account_tier_azurefn
#   repli_type                      = var.account_replication_type_azurefn
#   repli_kind                      = var.account_kind_azurefn
#   creator                         = var.creator
# }

# module "create_storage_container_azurefn" {
#   source                = "./modules/storage_container"
#   container_name        = var.container_name_azurefn
#   storage_account_name  = module.create_storage_account_azurefn.stroageaccount_name
#   access_type           = var.access_type_azurefn
# }

# resource "azurerm_app_service_plan" "azurefn_appsvcplan" {
#   name                = "${var.prefix}-${var.environment}-appsvcplan"
#   location            = var.location_name
#   resource_group_name = var.resource_group
#   kind                = "Linux"
#   reserved            = true
#   sku {
#     tier = var.fnapp_appservice_sku_tier
#     size = var.fnapp_appservice_sku_size
#   }
#   tags = {
#     environment = var.environment
#     Creator     = var.creator
#   }
# }
# resource "azurerm_function_app" "azurefn_function_app" {
#   name                      = "${var.prefix}-${var.environment}-azfunctionapp"
#   location                  = var.location_name
#   resource_group_name       = var.resource_group
#   app_service_plan_id       = azurerm_app_service_plan.azurefn_appsvcplan.id
#   storage_connection_string = module.create_storage_account_azurefn.azure_connectionstring
#   version                   = "~3"

#   tags = {
#     environment = var.environment
#     Creator     = var.creator
#   }
  
#   app_settings = {
#         FUNCTIONS_EXTENSION_VERSION               = "~3"
#         APPINSIGHTS_INSTRUMENTATIONKEY            = module.create_key_vault.appinsightskey
#         PriceBookBlobStorageConnectionString      = module.create_key_vault.azure_connectstr       
#         DOCKER_REGISTRY_SERVER_URL                = "https://${module.create_key_vault.docker_server}" 
#         DOCKER_REGISTRY_SERVER_USERNAME           = "${module.create_key_vault.docker_username}" 
#         DOCKER_REGISTRY_SERVER_PASSWORD           = "${module.create_key_vault.docker_password}" 
#         WEBSITE_CONTENTSHARE                      = module.create_storage_account_azurefn.stroageaccount_name        
#         AzureWebJobsStorage                       = module.create_storage_account_azurefn.azure_connectionstring
#         WEBSITE_CONTENTAZUREFILECONNECTIONSTRING  = module.create_storage_account_azurefn.azure_connectionstring
#         AzureSignalRConnectionString              = module.create_key_vault.signalr_url
#         WEBSITES_ENABLE_APP_SERVICE_STORAGE       = false 
#         ContainerName                             = module.create_key_vault.pricebook_blob_server_storage_container    
#   }

#   site_config {
#       always_on         = true
#       linux_fx_version  = "DOCKER|${module.create_key_vault.docker_server}/ngrp-functions-pricebook:${var.fnapp_image_tag}"
#   }
  
# }