
### Specify Backend to store Terraform State file
terraform {
 backend "azurerm" {
   resource_group_name   = "Terraform-Dev"
   storage_account_name  = "stngrpterraformdev"
   container_name        = "statefile"
   key                   = "terraform.tfstate"
 }
}
#end backend

### K8S cluster
module "create_k8s_cluster" {
  source              = "./modules/aks"
  location            = var.location
  resource_group      = var.resource_group
  k8s_cluster_name    = "${var.prefix}-${var.environment}-cluster"
  environment         = var.environment
  client_id           = var.client_id
  client_secret       = var.client_secret
  k8s_node_count      = var.k8s_node_count
  k8s_vm_size         = var.k8s_vm_size
  creator             = var.creator
} 
#end K8S cluster

### MySQL
module "create_mysql" {
  source            = "./modules/mysql"
  mysql_server_name = "${var.prefix}-${var.environment}-mysql"
  db_username       = "${var.prefix}-${var.environment}"
  db_password       = var.db_password
  location          = var.location
  resource_group    = var.resource_group
  environment       = var.environment
  sku_name          = var.mysql_sku_name
  creator           = var.creator
}
#end MySQL

### CosmosDB
module "create_cosmosdb" {
  source                        = "./modules/cosmosdb"
  cosmos_account_name           = "${var.prefix}-${var.environment}-cosmos"
  location                      = var.location
  resource_group                = var.resource_group
  environment                   = var.environment
  creator                       = var.creator
  cosmos_consistency_level      = var.cosmos_consistency_level
  cosmos_db_name                = var.cosmos_db_name
  cosmos_throughput             = var.cosmos_throughput
  customers_container_name      = var.customers_container_name
  orchestrations_container_name = var.orchestrations_container_name
  reporting_container_name      = var.reporting_container_name
  identifiers_container_name    = var.identifiers_container_name
  offers_container_name         = var.offers_container_name
  stores_container_name         = var.stores_container_name
  # enable_multi_master           = var.enable_multi_master
  # failover_location             = var.failover_location
  cosmos_db_kind                = var.cosmos_db_kind
  max_interval_in_seconds       = var.max_interval_in_seconds
  max_staleness_prefix          = var.max_staleness_prefix        
}
#end CosmosDB

### APIManager
module "create_apim" {
  source                                = "./modules/apim"
  apim_name                             = "${var.prefix}-${var.environment}-apim"
  location                              = var.location
  resource_group                        = var.resource_group
  environment                           = var.environment
  creator                               = var.creator
  publisher_name                        = var.apim_publisher_name
  publisher_email                       = var.apim_publisher_email
  sku_name                              = var.apim_sku_name
  host_name                             = var.apim_host_name
  # key_vault_id                          = var.apim_key_vault_id
  caper_exp_api_url                     = kubernetes_service.services-exp-api-order-api-service.load_balancer_ingress.0.ip
  mastercard_experience_api_url         = kubernetes_service.services-exp-api-mastercard-shop-anywhere.load_balancer_ingress.0.ip
  ngrp_auth_service_url                 = kubernetes_service.services-auth.load_balancer_ingress.0.ip
  pdi_experience_api_url                = kubernetes_service.services-exp-api-pdi-api.load_balancer_ingress.0.ip
  ngrp_orchestrator_url                 = kubernetes_service.services-orchestrator.load_balancer_ingress.0.ip
  store_service_url                     = kubernetes_service.services-store.load_balancer_ingress.0.ip
  inventory_service_url                 = kubernetes_service.services-inventory.load_balancer_ingress.0.ip
  jwt_secret                            = module.create_key_vault.jwt_secret
  certificate_key_vault_resource_group  = var.certificate_key_vault_resource_group
  certificate_key_vault_name            = var.certificate_key_vault_name
  certificate_name                      = var.certificate_name
  #store_file_upload_depends_on          = [module.create_store_event_topic_subscription_mcgill,module.create_store_event_topic_subscription_circlek_us]
}
#end APIManager

### App Insights
module "create_app_insights" {
  source                  = "./modules/appinsights"
  appinsights_name        = "${var.prefix}-${var.environment}-app-insights"
  location                = var.location
  resource_group          = var.resource_group
  environment             = var.environment
  creator                 = var.creator
  action_group_name       = "${var.prefix}-${var.environment}-action-grp"
  action_group_short_name = var.action_group_short_name
  webhook_receiver_name   = "${var.prefix}-${var.environment}-webhook"
  webhook_receiver_url    = var.webhook_receiver_url
}
#end App Insights

### Key Vault
module "create_key_vault" {
  source                                    = "./modules/vault"
  location                                  = var.location
  resource_group                            = var.resource_group
  environment                               = var.environment
  prefix                                    = var.prefix
  app_tenant_id                             = var.app_tenant_id
  app_object_id                             = var.app_object_id
  mysql_host                                = module.create_mysql.mysql_url
  db_username                               = "${var.prefix}-${var.environment}"
  db_password                               = var.db_password
  cosmosdb_endpoint                         = module.create_cosmosdb.cosmos-db-endpoint
  cosmosdb_master_key                       = module.create_cosmosdb.cosmos-db-primary_master_key
  mysql_server_name                         = module.create_mysql.mysql_name
  instrument_key                            = module.create_app_insights.instrumentation_key
  azure_connectionstring_report             = module.create_storage_account_server.azure_connectionstring
  pricebook_azfun_signalr_url               = azurerm_function_app.pricebook_function_app.default_hostname
  signalr_conncetionstring                  = module.create_signalr.primary_connection_string
  pricebook_blob_temp_storage_accountname   = module.create_storage_account_temp.stroageaccount_name
  pricebook_blob_temp_storage_accountkey    = module.create_storage_account_temp.storageaccount_key
  pricebook_blob_temp_storage_container     = module.create_storage_container_temp.container_name
  pricebook_blob_temp_storage_saskey        = data.azurerm_storage_account_sas.temp_storage_sas.sas
  pricebook_blob_server_storage_accountname = module.create_storage_account_server.stroageaccount_name
  pricebook_blob_server_storage_accountkey  = module.create_storage_account_server.storageaccount_key
  pricebook_blob_server_storage_container   = module.create_storage_container_pricebook.container_name
  creator                                   = var.creator
  apim_object_id                            = module.create_apim.apim_object_id
  sku_name                                  = var.key_vault_sku_name
  blob_report_container_name                = module.create_storage_container_reports.container_name
  jwt_secret                                = var.jwt_secret
  acr_server                                = var.acr_server
  acr_email                                 = var.acr_email
  acr_username                              = var.acr_username
  acr_pwd                                   = var.acr_pwd
  mastercard_auth_name                      = var.mastercard_auth_name
  mastercard_auth_pwd                       = var.mastercard_auth_pwd
  mastercard_auth_tenant                    = var.mastercard_auth_tenant
  moneris_api_token                         = var.moneris_api_token
  moneris_store_id                          = var.moneris_store_id
  pricebook_negotiate_function_key          = var.pricebook_negotiate_function_key
  pricebook_cache_maintenance_interval      = var.pricebook_cache_maintenance_interval
  pricebook_cache_max_size                  = var.pricebook_cache_max_size
  pricebook_cache_timeout                   = var.pricebook_cache_timeout
  pricebook_memory_setting                  = var.pricebook_memory_setting
  menu_event_topic_endpoint                 = "test"
  menu_event_topic_key                      = "test"
  history_prices_to_keep                    = var.history_prices_to_keep
  history_combos_to_keep                    = var.history_combos_to_keep
}
#end Key Vault

### Server Storage Account & Container
module "create_storage_account_server" {
  source                          = "./modules/storageaccount"
  stroageaccount_name             = var.storage_account_name_server
  location                        = var.location_name
  resource_group                  = var.resource_group
  environment                     = var.environment
  tier                            = var.account_tier_server
  repli_type                      = var.account_replication_type_server
  repli_kind                      = var.account_kind_server
  creator                         = var.creator
}

## Pricebook container
module "create_storage_container_pricebook" {
  source                = "./modules/storage_container"
  container_name        = var.container_name_pricebook
  storage_account_name  = module.create_storage_account_server.stroageaccount_name
  access_type           = var.access_type_pricebook
}
## Cardinfo container
module "create_storage_container_cardinfo" {
  source                = "./modules/storage_container"
  container_name        = var.container_name_cardinfo
  storage_account_name  = module.create_storage_account_server.stroageaccount_name
  access_type           = var.access_type_cardinfo
}
## Reports container
module "create_storage_container_reports" {
  source                = "./modules/storage_container"
  container_name        = var.container_name_report
  storage_account_name  = module.create_storage_account_server.stroageaccount_name
  access_type           = var.access_type_report
}
## Files container
module "create_storage_container_files" {
  source                = "./modules/storage_container"
  container_name        = var.files_conatiner_name
  storage_account_name  = module.create_storage_account_server.stroageaccount_name
  access_type           = var.files_conatiner_access
}
## Filedeadletter container
module "create_storage_container_filedeadletter" {
  source                = "./modules/storage_container"
  container_name        = var.file_dead_letter_conatiner_name
  storage_account_name  = module.create_storage_account_server.stroageaccount_name
  access_type           = var.file_dead_letter_conatiner_access
}
#end Server Storage Account & Container

### Temp Storage Account & Container
module "create_storage_account_temp" {
  source                          = "./modules/storageaccount"
  stroageaccount_name             = var.storage_account_name_temp
  location                        = var.location_name
  resource_group                  = var.resource_group
  environment                     = var.environment
  tier                            = var.account_tier_temp
  repli_type                      = var.account_replication_type_temp
  repli_kind                      = var.account_kind_temp
  creator                         = var.creator
}
## Temp container
module "create_storage_container_temp" {
  source                = "./modules/storage_container"
  container_name        = var.container_name_temp
  storage_account_name  = module.create_storage_account_temp.stroageaccount_name
  access_type           = var.access_type_temp
}
## sas
data "azurerm_storage_account_sas" "temp_storage_sas" {
  connection_string = module.create_storage_account_temp.azure_connectionstring
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = true
    table = true
    file  = true
  }

  start  = "2020-03-01"
  expiry = "2099-04-21"

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
  }
}

# resource "azurerm_storage_management_policy" "temp_storage_delete_rule" {
#   storage_account_id = module.create_storage_account_temp.stroageaccount_id

#   rule {
#     name    = "deletionRule"
#     enabled = true
#     filters {
#       prefix_match = ["temp"]
#       blob_types   = ["blockBlob"]
#     }
#     actions {
#       base_blob {
#         delete_after_days_since_modification_greater_than = var.delete_temp_blob_after_days
#       }
#     }
#   }
# }
#end Temp Storage Account

### Signal R Service
module "create_signalr" {
  source                          = "./modules/signalr"
  signalr_name                    = "${var.prefix}-${var.environment}-signalr"
  location                        = var.signalr_azure_location
  resource_group                  = var.resource_group
  environment                     = var.environment
  creator                         = var.creator
}
#end Signal R Service

### Storage account event grid subscription
module "create_storage_account_event_subscription" {
  source                          = "./modules/event_grid/storage_account_event_subscription"
  event_subscription_name         = var.storage_account_event_subscription_name
  storage_account_id              = module.create_storage_account_server.stroageaccount_id
  functionapp_endpoint_base       = azurerm_function_app.file_function_app.default_hostname
  event_grid_function_name        = "announceFile"
  function_host_key               = module.get_file_function_key.host_key
  subject_begins_with             = var.storage_account_subject_begins_with
  file_dead_letter_conatiner_name = module.create_storage_container_filedeadletter.container_name
  max_delivery_attempts           = var.storage_account_max_delivery_attempts
  event_time_to_live              = var.storage_account_event_time_to_live
}
## end Storage account event grid subscription

### Custom event grid Topic
module "create_event_topic" {
  source                          = "./modules/event_grid/event_topic"
  event_topic_name                = "${var.prefix}-${var.environment}-topic"
  location                        = var.location
  resource_group                  = var.resource_group
  environment                     = var.environment
  creator                         = var.creator
}
## end Custom event grid Topic

### Custom event grid Topic subscriptions for store
module "create_store_event_topic_subscription_mcgill" {
  source                          = "./modules/event_grid/event_topic_event_subscription"
  event_subscription_name         = var.mcgill_event_subscription_name
  scope                           = module.create_event_topic.event_topic_id
  topic_name                      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.EventGrid/topics/${var.prefix}-${var.environment}-topic"
  webhook_endpoint_url            = "${module.create_apim.apim_gateway}/store/v1/mcgill/files?Authorization=${var.mcgill_webhook_token}"
  subject_begins_with             = var.mcgill_subject_begins_with
  storage_account_id              = module.create_storage_account_server.stroageaccount_id
  file_dead_letter_conatiner_name = module.create_storage_container_filedeadletter.container_name
  max_delivery_attempts           = var.mcgill_max_delivery_attempts
  event_time_to_live              = var.mcgill_event_time_to_live
  event_subscription_depends_on   = [module.create_apim]
}

module "create_store_event_topic_subscription_circlek_us" {
  source                          = "./modules/event_grid/event_topic_event_subscription"
  event_subscription_name         = var.circlek_us_event_subscription_name
  scope                           = module.create_event_topic.event_topic_id
  topic_name                      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.EventGrid/topics/${var.prefix}-${var.environment}-topic"
  webhook_endpoint_url            = "${module.create_apim.apim_gateway}/store/v1/circlek-us/files?Authorization=${var.circlek_us_webhook_token}"
  subject_begins_with             = var.circlek_us_subject_begins_with
  storage_account_id              = module.create_storage_account_server.stroageaccount_id
  file_dead_letter_conatiner_name = module.create_storage_container_filedeadletter.container_name
  max_delivery_attempts           = var.circlek_us_max_delivery_attempts
  event_time_to_live              = var.circlek_us_event_time_to_live
  event_subscription_depends_on   = [module.create_apim]
 }
## end Custom event grid Topic subscriptions for store

### Custom event grid Topic subscriptions for inventory
module "create_inventory_event_topic_subscription_mcgill" {
  source                          = "./modules/event_grid/event_topic_event_subscription"
  event_subscription_name         = var.mcgill_inventory_event_subscription_name
  scope                           = module.create_event_topic.event_topic_id
  topic_name                      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.EventGrid/topics/${var.prefix}-${var.environment}-topic"
  webhook_endpoint_url            = "${module.create_apim.apim_gateway}/inventory/v1/mcgill/webhook/files?Authorization=${var.mcgill_inventory_webhook_token}"
  subject_begins_with             = var.mcgill_inventory_subject_begins_with
  storage_account_id              = module.create_storage_account_server.stroageaccount_id
  file_dead_letter_conatiner_name = module.create_storage_container_filedeadletter.container_name
  max_delivery_attempts           = var.mcgill_inventory_max_delivery_attempts
  event_time_to_live              = var.mcgill_inventory_event_time_to_live
  event_subscription_depends_on   = [module.create_apim,kubernetes_deployment.services-inventory-deployment,kubernetes_service.services-inventory]
}

module "create_inventory_event_topic_subscription_circlek_us" {
  source                          = "./modules/event_grid/event_topic_event_subscription"
  event_subscription_name         = var.circlek_us_inventory_event_subscription_name
  scope                           = module.create_event_topic.event_topic_id
  topic_name                      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.EventGrid/topics/${var.prefix}-${var.environment}-topic"
  webhook_endpoint_url            = "${module.create_apim.apim_gateway}/inventory/v1/circlek-us/webhook/files?Authorization=${var.circlek_us_inventory_webhook_token}"
  subject_begins_with             = var.circlek_us_inventory_subject_begins_with
  storage_account_id              = module.create_storage_account_server.stroageaccount_id
  file_dead_letter_conatiner_name = module.create_storage_container_filedeadletter.container_name
  max_delivery_attempts           = var.circlek_us_inventory_max_delivery_attempts
  event_time_to_live              = var.circlek_us_inventory_event_time_to_live
  event_subscription_depends_on   = [module.create_apim,kubernetes_deployment.services-inventory-deployment,kubernetes_service.services-inventory]
 }
## end Custom event grid Topic subscriptions for inventory

### function-app app service plan
resource "azurerm_app_service_plan" "azurefn_appsvcplan" {
  name                = "${var.prefix}-${var.environment}-appsvcplan"
  location            = var.location_name
  resource_group_name = var.resource_group
  kind                = "Linux"
  reserved            = true
  sku {
    tier = var.fnapp_appservice_sku_tier
    size = var.fnapp_appservice_sku_size
  }
  tags = {
    environment = var.environment
    Creator     = var.creator
  }
}
## end function-app app service plan

### Pricebook funtion
module "create_storage_account_azurefn" {
  source                          = "./modules/storageaccount"
  stroageaccount_name             = var.storage_account_name_azurefn
  location                        = var.location_name
  resource_group                  = var.resource_group
  environment                     = var.environment
  tier                            = var.account_tier_azurefn
  repli_type                      = var.account_replication_type_azurefn
  repli_kind                      = var.account_kind_azurefn
  creator                         = var.creator
}

module "create_storage_container_azurefn" {
  source                = "./modules/storage_container"
  container_name        = var.container_name_azurefn
  storage_account_name  = module.create_storage_account_azurefn.stroageaccount_name
  access_type           = var.access_type_azurefn
}

resource "azurerm_function_app" "pricebook_function_app" {
  name                      = "${var.prefix}-${var.environment}-azfunctionapp"
  location                  = var.location_name
  resource_group_name       = var.resource_group
  app_service_plan_id       = azurerm_app_service_plan.azurefn_appsvcplan.id
  storage_connection_string = module.create_storage_account_azurefn.azure_connectionstring
  version                   = "~3"
  os_type                   = "linux"

  tags = {
    environment = var.environment
    Creator     = var.creator
  }
  
  app_settings = {
        FUNCTIONS_EXTENSION_VERSION               = "~3"
        APPINSIGHTS_INSTRUMENTATIONKEY            = module.create_key_vault.appinsightskey
        PriceBookBlobStorageConnectionString      = module.create_key_vault.azure_connectstr       
        DOCKER_REGISTRY_SERVER_URL                = "https://${module.create_key_vault.docker_server}" 
        DOCKER_REGISTRY_SERVER_USERNAME           = "${module.create_key_vault.docker_username}" 
        DOCKER_REGISTRY_SERVER_PASSWORD           = "${module.create_key_vault.docker_password}" 
        WEBSITE_CONTENTSHARE                      = module.create_storage_account_azurefn.stroageaccount_name        
        AzureWebJobsStorage                       = module.create_storage_account_azurefn.azure_connectionstring
        WEBSITE_CONTENTAZUREFILECONNECTIONSTRING  = module.create_storage_account_azurefn.azure_connectionstring
        AzureSignalRConnectionString              = module.create_key_vault.signalr_url
        WEBSITES_ENABLE_APP_SERVICE_STORAGE       = false 
        ContainerName                             = module.create_key_vault.pricebook_blob_server_storage_container    
  }

  site_config {
      always_on         = true
      linux_fx_version  = "DOCKER|${module.create_key_vault.docker_server}/ngrp-functions-pricebook:${var.fnapp_image_tag}"
  }
  
}

# module "get_negotiate_function_key" {
#   source                = "./modules/functionkeys_pricebook"
#   function_app_name     = azurerm_function_app.pricebook_function_app.name
#   #function_name         = "negotiate"
#   resource_group_name   = var.resource_group
# }
## end Pricebook function

### File Announce funtion
module "create_storage_account_azure_file_fn" {
  source                          = "./modules/storageaccount"
  stroageaccount_name             = var.file_storage_account_name_azurefn
  location                        = var.location_name
  resource_group                  = var.resource_group
  environment                     = var.environment
  tier                            = var.file_account_tier_azurefn
  repli_type                      = var.file_account_replication_type_azurefn
  repli_kind                      = var.file_account_kind_azurefn
  creator                         = var.creator
}

module "create_storage_container_azure_file_fn" {
  source                = "./modules/storage_container"
  container_name        = var.file_container_name_azurefn
  storage_account_name  = module.create_storage_account_azure_file_fn.stroageaccount_name
  access_type           = var.file_access_type_azurefn
}

resource "azurerm_function_app" "file_function_app" {
  name                      = "${var.prefix}-${var.environment}-file-azfunctionapp"
  location                  = var.location_name
  resource_group_name       = var.resource_group
  app_service_plan_id       = azurerm_app_service_plan.azurefn_appsvcplan.id
  storage_connection_string = module.create_storage_account_azure_file_fn.azure_connectionstring
  version                   = "~3"
  os_type                   = "linux"

  tags = {
    environment = var.environment
    Creator     = var.creator
  }
  
  app_settings = {
        APPINSIGHTS_INSTRUMENTATIONKEY            = module.create_key_vault.appinsightskey  
        AzureWebJobsStorage                       = module.create_storage_account_azure_file_fn.azure_connectionstring  
        blobStorageAccountKey                     = module.create_storage_account_server.storageaccount_key
        blobStorageAccountName                    = module.create_storage_account_server.stroageaccount_name
        DOCKER_REGISTRY_SERVER_URL                = "https://${module.create_key_vault.docker_server}" 
        DOCKER_REGISTRY_SERVER_USERNAME           = module.create_key_vault.docker_username
        DOCKER_REGISTRY_SERVER_PASSWORD           = module.create_key_vault.docker_password
        fileAnnounceTopic                         = module.create_event_topic.event_topic_endpoint
        fileAnnounceTopicKey                      = module.create_event_topic.event_topic_access_key
        FUNCTIONS_EXTENSION_VERSION               = "~3"
        WEBSITES_ENABLE_APP_SERVICE_STORAGE       = false    
  }

  site_config {
      always_on         = true
      linux_fx_version  = "DOCKER|${module.create_key_vault.docker_server}/ngrp-functions-file:${var.file_fnapp_image_tag}"
  }  
}

module "get_file_function_key" {
  source               = "./modules/functionkeys_file"
  function_app_name   = azurerm_function_app.file_function_app.name
  resource_group_name = var.resource_group
}
## end File Announce function