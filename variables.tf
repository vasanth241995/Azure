# Common Variables
variable "prefix" {
  description = "The prefix which should be used for all resources"
}
variable "location" {
  description = "Azure location to deploy"
}

variable "location_name" {
  description = "Azure location name to deploy storage account"
}
variable "environment" {
  description = "Specify the environment - dev/stg/prod"
}
variable "resource_group" {
  description = "Specify resource group"
}
variable "common_resource_group" {
  description = "Specify Common resource group"
}
/*variable "k8s_cluster_name" {
  description = "Kubernates cluster name"
}*/
variable "k8s_node_count" {
  description = "Kubernates node count"
}
variable "k8s_vm_size" {
  description = "Kubernates VM size"
}
/*variable "registry_name" {
  description = "Azure registry name"
}
variable "mysql_server_name" {
  description = "MySQL server name"
}
variable "db_username" {
  description = "MySQL DB username"
}*/
###MySQL variables
variable "db_password" {
  description = "MySQL DB password"
}
variable "mysql_sku_name" {
  description = "MySQL SKU Name"
}

/*variable "cosmosdb_name" {
  description = "Cosmos DB name"
}
variable "traffic_manager_name" {
  description = "Traffic Manager Name"
}
variable "traffic_manager_endpoint" {
  description = "Traffic Manager Endpoint"
}
variable "traffic_manager_endpoint_target" {
  description = "Traffic Manager Endpoint Target"
}
variable "apim_name" {
  description = "API Manager name"
}*/

# Authentication
variable "subscription_id" {
  description = "Azure subscription ID"
}
variable "client_id" {
  description = "Azure client ID"
}
variable "client_secret" {
  description = "Azure client Secret"
}
variable "tenant_id" {
  description = "Azure Tenent ID"
}

# App permission
variable "app_tenant_id" {
  description = "Application tenant id for access permission"
}
variable "app_object_id" {
  description = "Application object id for access permission"
}

# Server Storage Account
variable "storage_account_name_server" {
  description = "Storage account name for server"
}

variable "account_tier_server" {
  description = "Storage account name for server account tier"
}

variable "account_replication_type_server" {
  description = "Storage account name for server replication type"
}

variable "account_kind_server" {
  description = "Storage account name for server account kind"
}

#Pricebook Container
variable "container_name_pricebook" {
  description = "Container name"
}

variable "access_type_pricebook" {
  description = "Container access type"
}

#CardInfo Container
variable "container_name_cardinfo" {
  description = "Container name"
}

variable "access_type_cardinfo" {
  description = "Container access type"
}

#Report Container
variable "container_name_report" {
  description = "Container name"
}

variable "access_type_report" {
  description = "Container access type"
}


###azure function variables
variable "fnapp_appservice_sku_tier" {
  description = "function app app service sku pricing tier"
}

variable "fnapp_appservice_sku_size" {
  description = "function app app service sku size"
}

###azure Pricebook function variables
variable "fnapp_image_tag" {
  description = "function app image tag number"
}

variable "storage_account_name_azurefn" {
  description = "Storage account name for azurefn"
}

variable "account_tier_azurefn" {
  description = "Storage account name for azurefn account tier"
}

variable "account_replication_type_azurefn" {
  description = "Storage account name for azurefn replication type"
}

variable "account_kind_azurefn" {
  description = "Storage account name for azurefn account kind"
}

variable "container_name_azurefn" {
  description = "Container name"
}

variable "access_type_azurefn" {
  description = "Container access type"
}

###services related variables
variable "report_service_image_tag"{
  description = "image tag number of report service to be deployed"
}

variable "costumer_service_image_tag"{
  description = "image tag number of customer service to be deployed"
}

variable "api_mastercard_service_image_tag"{
  description = "image tag number of api_mastercard service to be deployed"
}

# variable "api_offer_service_image_tag"{
#   description = "image tag number of api_offer service to be deployed"
# }

variable "api_oder_service_image_tag"{
  description = "image tag number of api_oder service to be deployed"
}

variable "api_pdi_service_image_tag"{
  description = "image tag number of api_pdi service to be deployed"
}

variable "orchestrator_service_image_tag"{
  description = "image tag number of orchestrator service to be deployed"
}

variable "auth_service_image_tag"{
  description = "image tag number of auth service to be deployed"
}

variable "moneris_service_image_tag"{
  description = "image tag number of moneris service to be deployed"
}

variable "pricebook_service_image_tag"{
  description = "image tag number of pricebook service to be deployed"
}

variable "tax_service_image_tag"{
  description = "image tag number of tax service to be deployed"
}

variable "totalizer_service_image_tag"{
  description = "image tag number of totalizer service to be deployed"
}

variable "store_service_image_tag"{
  description = "image tag number of store service to be deployed"
}

variable "inventory_service_image_tag"{
  description = "image tag number of inventory service to be deployed"
}

variable "menu_service_image_tag"{
  description = "image tag number of menu service to be deployed"
}

###Temp storage Account
variable "storage_account_name_temp" {
  description = "Storage account name for temp"
}

variable "account_tier_temp" {
  description = "Storage account name for temp account tier"
}

variable "account_replication_type_temp" {
  description = "Storage account name for temp replication type"
}

variable "account_kind_temp" {
  description = "Storage account name for temp account kind"
}

variable "container_name_temp" {
  description = "Container name"
}

variable "access_type_temp" {
  description = "Container access type"
}

variable "delete_temp_blob_after_days" {
  description = "delete temp container rule"
}

###Tags
variable "creator" {
  description = "Name of the organization who creates the resources"
}

variable "signalr_azure_location" {
  description = "Signal R service Location"
}

#varibale only required for production
# variable "prod_container_registry_name" {
#   description = "production container registry name"
# }

#Cosmos Variables
variable "cosmos_consistency_level" {
  description = "Cosmos consistency level"
}
variable "cosmos_db_name" {
  description = "Cosmos DB name"
}
variable "cosmos_throughput" {
  description = "Cosmos DB throughput"
}
variable "customers_container_name" {
  description = "customers container name"
}
variable "orchestrations_container_name" {
  description = "orchestrations container name"
}
variable "reporting_container_name" {
  description = "reporting container name"
}
# variable "enable_multi_master" {
#   description = "enable multi master"
# }
# variable "failover_location" {
#   description = "The name of the Azure region to host replicated data"
# }
variable "cosmos_db_kind" {
  description = "Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB"
}
variable "max_interval_in_seconds" {
  description = "max interval in seconds"
}
variable "max_staleness_prefix" {
  description = "max staleness prefix"
}
variable "identifiers_container_name" {
  description = "identifiers container name"
}
variable "offers_container_name" {
  description = "offers container name"
}
variable "stores_container_name" {
  description = "stores container name"
}
#API Management
variable "apim_publisher_name" {
  description = "publisher name"
}
variable "apim_publisher_email" {
  description = "publisher email"
}
variable "apim_sku_name" {
  description = "sku name"
}
variable "apim_host_name" {
  description = "host name"
}
# variable "apim_key_vault_id" {
#   description = "key vault id storing the certificate"
# }
variable "certificate_key_vault_resource_group" {
  description = "certificate key vault resource group"
}
variable "certificate_key_vault_name" {
  description = "certificate key vault name"
}
variable "certificate_name" {
  description = "certificate name"
}
###Key-Vault Variable
variable "key_vault_sku_name" {
  description = "keyvault sku name"
}
variable "jwt_secret" {
  description = "jwt secret"
}
variable "acr_server" {
  description = "azure conatiner registry server"
}
variable "acr_email" {
  description = "azure conatiner registry email"
}
variable "acr_username" {
  description = "azure conatiner registry username"
}
variable "acr_pwd" {
  description = "azure conatiner registry password"
}
variable "mastercard_auth_name" {
  description = "mastercard auth name"
}
variable "mastercard_auth_pwd" {
  description = "mastercard auth password"
}
variable "mastercard_auth_tenant" {
  description = "mastercard auth tenant"
}
variable "moneris_api_token" {
  description = "moneris api token"
}
variable "moneris_store_id" {
  description = "moneris store id"
}
variable "pricebook_negotiate_function_key" {
  description = "pricebook negotiate function key"
}
variable "history_prices_to_keep" {
  description = "history prices to keep"
}
variable "history_combos_to_keep" {
  description = "history prices to keep"
}
###App Insights Variables
variable "action_group_short_name" {
  description = "action group short name"
}
variable "webhook_receiver_url" {
  description = "webhook receiver url"
}
###Event grid
variable "files_conatiner_name" {
  description = "Files container name"
}
variable "files_conatiner_access" {
  description = "Files container access type"
}
variable "file_dead_letter_conatiner_name" {
  description = "Specifies the name of the Storage blob container that is the destination of the deadletter events"
}
variable "file_dead_letter_conatiner_access" {
  description = "File dead letter container access type"
}
### Storage account event grid subscription
variable "storage_account_event_subscription_name" {
  description = "storage account event subscription name"
}
variable "storage_account_subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "storage_account_max_delivery_attempts" {
  description = "Specifies the maximum number of delivery retry attempts for events."
}
variable "storage_account_event_time_to_live" {
  description = "Specifies the time to live (in minutes) for events"
}
### Custom event grid Topic subscriptions - Store Mcgill
variable "mcgill_event_subscription_name" {
  description = "Event subscription name"
}
variable "mcgill_subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "mcgill_max_delivery_attempts" {
  description = "Specifies the maximum number of delivery retry attempts for events."
}
variable "mcgill_event_time_to_live" {
  description = "Specifies the time to live (in minutes) for events"
}
variable "mcgill_webhook_token" {
  description = "Specifies webhook token for mcgill"
}
### Custom event grid Topic subscriptions - Store Cirlek-US
variable "circlek_us_event_subscription_name" {
  description = "Event subscription name"
}
variable "circlek_us_subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "circlek_us_max_delivery_attempts" {
  description = "Specifies the maximum number of delivery retry attempts for events."
}
variable "circlek_us_event_time_to_live" {
  description = "Specifies the time to live (in minutes) for events"
}
variable "circlek_us_webhook_token" {
  description = "Specifies webhook token for Circlek-US"
}
### Custom event grid Topic subscriptions - Inventory Mcgill
variable "mcgill_inventory_event_subscription_name" {
  description = "Event subscription name"
}
variable "mcgill_inventory_subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "mcgill_inventory_max_delivery_attempts" {
  description = "Specifies the maximum number of delivery retry attempts for events."
}
variable "mcgill_inventory_event_time_to_live" {
  description = "Specifies the time to live (in minutes) for events"
}
variable "mcgill_inventory_webhook_token" {
  description = "Specifies webhook token for mcgill"
}
### Custom event grid Topic subscriptions - Inventory Cirlek-US
variable "circlek_us_inventory_event_subscription_name" {
  description = "Event subscription name"
}
variable "circlek_us_inventory_subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "circlek_us_inventory_max_delivery_attempts" {
  description = "Specifies the maximum number of delivery retry attempts for events."
}
variable "circlek_us_inventory_event_time_to_live" {
  description = "Specifies the time to live (in minutes) for events"
}
variable "circlek_us_inventory_webhook_token" {
  description = "Specifies webhook token for Circlek-US"
}
###azure File Announce function variables
variable "file_fnapp_image_tag" {
  description = "function app image tag number"
}

variable "file_storage_account_name_azurefn" {
  description = "Storage account name for azurefn"
}

variable "file_account_tier_azurefn" {
  description = "Storage account name for azurefn account tier"
}

variable "file_account_replication_type_azurefn" {
  description = "Storage account name for azurefn replication type"
}

variable "file_account_kind_azurefn" {
  description = "Storage account name for azurefn account kind"
}

variable "file_container_name_azurefn" {
  description = "Container name"
}

variable "file_access_type_azurefn" {
  description = "Container access type"
}
###Pricebook settings
variable "pricebook_cache_maintenance_interval" {
  description = "pricebook_cache_maintenance_interval"
}
variable "pricebook_cache_max_size" {
  description = "pricebook_cache_max_size"
}
variable "pricebook_cache_timeout" {
  description = "pricebook_cache_timeout"
}
variable "pricebook_memory_setting" {
  description = "pricebook container memory limit"
}