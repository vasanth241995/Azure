# Common Variables
variable "location" {
  description = "Azure location to deploy"
}
variable "environment" {
  description = "Specify the environment - dev/stg/prod"
}
variable "resource_group" {
  description = "Specify resource group"
}
variable "prefix" {
  description = "The prefix which should be used for all resources"
}
variable "app_tenant_id" {
  description = "Application tenant id for access permission"
}
variable "app_object_id" {
  description = "Application object id for access permission"
}
variable "mysql_host" {
}
variable "db_username" {
}
variable "db_password" {
}
variable "cosmosdb_endpoint" {
}
variable "cosmosdb_master_key" {
}
variable "mysql_server_name" {
}
variable "instrument_key" {
   description = "App Insights Instrumentation key"
}
variable "azure_connectionstring_report" {
   description = "Azure BLOB connection string for reports"
}
variable "pricebook_azfun_signalr_url" {
   description = "pricebook function url"
}
variable "signalr_conncetionstring" {
   description = "Signal R Service conncetionstring"
}
variable "pricebook_blob_temp_storage_accountname" {
   description = "Pricebook temperory storage account name"
}
variable "pricebook_blob_temp_storage_accountkey" {
   description = "Pricebook temperory storage account key"
}
variable "pricebook_blob_temp_storage_container" {
   description = "Pricebook temperory storage conatainer name"
}
variable "pricebook_blob_temp_storage_saskey" {
   description = "Pricebook temperory storage SAS key"
}
variable "pricebook_blob_server_storage_accountname" {
   description = "Pricebook Server storage account name"
}
variable "pricebook_blob_server_storage_accountkey" {
   description = "Pricebook Server storage account key"
}
variable "pricebook_blob_server_storage_container" {
   description = "Pricebook Server storage container name"
}
variable "creator" {
  description = "Creator"
}
variable "apim_object_id" {
  description = "API Manager objet ID"
}
variable "sku_name" {
  description = "keyvault sku name"
}
variable "blob_report_container_name" {
  description = "report storage container name"
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
variable "menu_event_topic_endpoint" {
  description = "meny event topic endpoint"
}
variable "menu_event_topic_key" {
  description = "meny event topic key"
}
variable "history_prices_to_keep" {
  description = "history prices to keep"
}
variable "history_combos_to_keep" {
  description = "history prices to keep"
}



