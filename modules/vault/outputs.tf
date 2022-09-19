# output "mysql_host_secret" {
#   value = azurerm_key_vault_secret.mysql_host.value
# }
output "replica_count" {
  value = azurerm_key_vault_secret.replica_count.value
}
output "blob_report_container_name" {
  value = azurerm_key_vault_secret.blob_report_container_name.value
}
output "azure_connectstr" {
  value = azurerm_key_vault_secret.azure_connectstr.value
}
output "appinsightskey" {
  value = azurerm_key_vault_secret.appinsightskey.value
}
output "jwt_secret" {
  value = azurerm_key_vault_secret.jwt_secret.value
}
output "reporting_uri" {
  value = azurerm_key_vault_secret.reporting_uri.value
}
output "reporting_key" {
  value = azurerm_key_vault_secret.reporting_key.value
}
output "mysql_db_driver" {
  value = azurerm_key_vault_secret.mysql_db_driver.value
}
output "mysql_db_url" {
  value = azurerm_key_vault_secret.mysql_db_url.value
}
output "mysql_db_username" {
  value = azurerm_key_vault_secret.mysql_db_username.value
}
output "mysql_db_password" {
  value = azurerm_key_vault_secret.mysql_db_password.value
}
output "deployment_type" {
  value = azurerm_key_vault_secret.deployment_type.value
}
output "docker_server" {
  value = azurerm_key_vault_secret.docker_server.value
}
output "docker_email" {
  value = azurerm_key_vault_secret.docker_email.value
}
output "docker_username" {
  value = azurerm_key_vault_secret.docker_username.value
}
output "docker_password" {
  value = azurerm_key_vault_secret.docker_password.value
}
output "orchestrator_base_url" {
  value = azurerm_key_vault_secret.orchestrator_base_url.value
}
output "customer_service_base_url" {
  value = azurerm_key_vault_secret.customer_service_base_url.value
}
output "mastercard_service_base_url" {
  value = azurerm_key_vault_secret.mastercard_service_base_url.value
}
output "mastercard_auth_base_url" {
  value = azurerm_key_vault_secret.mastercard_auth_base_url.value
}
output "mastercard_auth_name" {
  value = azurerm_key_vault_secret.mastercard_auth_name.value
}
output "mastercard_auth_password" {
  value = azurerm_key_vault_secret.mastercard_auth_password.value
}
output "mastercard_auth_tenant" {
  value = azurerm_key_vault_secret.mastercard_auth_tenant.value
}
output "thirdbridge_service_base_url" {
  value = azurerm_key_vault_secret.thirdbridge_service_base_url.value
}
output "pricebook_service_url" {
  value = azurerm_key_vault_secret.pricebook_service_url.value
}
output "report_service_url" {
  value = azurerm_key_vault_secret.report_service_url.value
}
output "tax_service_url" {
  value = azurerm_key_vault_secret.tax_service_url.value
}
output "totalizer_service_url" {
  value = azurerm_key_vault_secret.totalizer_service_url.value
}
output "moneris_service_url" {
  value = azurerm_key_vault_secret.moneris_service_url.value
}
output "cosmos_db_id" {
  value = azurerm_key_vault_secret.cosmos_db_id.value
}
output "cosmos_db_host" {
  value = azurerm_key_vault_secret.cosmos_db_host.value
}
output "cosmos_db_container_id" {
  value = azurerm_key_vault_secret.cosmos_db_container_id.value
}
output "spring_profiles_active" {
  value = azurerm_key_vault_secret.spring_profiles_active.value
}
output "moneris_test_mode" {
  value = azurerm_key_vault_secret.moneris_test_mode.value
}
output "moneris_pre_auth_amount" {
  value = azurerm_key_vault_secret.moneris_pre_auth_amount.value
}
output "moneris_api_token" {
  value = azurerm_key_vault_secret.moneris_api_token.value
}
output "moneris_store_id" {
  value = azurerm_key_vault_secret.moneris_store_id.value
}
output "pricebook_blob_container" {
  value = azurerm_key_vault_secret.pricebook_blob_container.value
}
output "pricebook_azfun_signalr_url" {
  value = azurerm_key_vault_secret.pricebook_azfun_signalr_url.value
}
output "signalr_url" {
  value = azurerm_key_vault_secret.signalr_url.value
}
output "pricebook_azfun_signalr_negotiate_key" {
  value = azurerm_key_vault_secret.pricebook_azfun_signalr_negotiate_key.value
}
output "pricebook_blob_server_storage_container" {
  value = azurerm_key_vault_secret.pricebook_blob_server_storage_container.value
}
output "pricebook_blob_temp_storage_accountname" {
  value = azurerm_key_vault_secret.pricebook_blob_temp_storage_accountname.value
}
output "pricebook_blob_temp_storage_saskey" {
  value = azurerm_key_vault_secret.pricebook_blob_temp_storage_saskey.value
}
output "pricebook_blob_temp_storage_accountkey" {
  value = azurerm_key_vault_secret.pricebook_blob_temp_storage_accountkey.value
}
output "pricebook_blob_temp_storage_container" {
  value = azurerm_key_vault_secret.pricebook_blob_temp_storage_container.value
}
output "pricebook_blob_server_storage_accountname" {
  value = azurerm_key_vault_secret.pricebook_blob_server_storage_accountname.value
}
output "pricebook_blob_server_storage_accountkey" {
  value = azurerm_key_vault_secret.pricebook_blob_server_storage_accountkey.value
}
output "auth_service_url" {
  value = azurerm_key_vault_secret.auth_service_url.value
}
output "store_service_url" {
  value = azurerm_key_vault_secret.store_service_url.value
}
output "pricebook_cache_maintenance_interval" {
  value = azurerm_key_vault_secret.pricebook_cache_maintenance_interval.value
}
output "pricebook_cache_max_size" {
  value = azurerm_key_vault_secret.pricebook_cache_max_size.value
}
output "pricebook_cache_timeout" {
  value = azurerm_key_vault_secret.pricebook_cache_timeout.value
}
output "pricebook_memory_setting" {
  value = azurerm_key_vault_secret.pricebook_memory_setting.value
}
output "menu_event_topic_endpoint" {
  value = azurerm_key_vault_secret.menu_event_topic_endpoint.value
}
output "menu_event_topic_key" {
  value = azurerm_key_vault_secret.menu_event_topic_key.value
}
output "history_prices_to_keep" {
  value = azurerm_key_vault_secret.history_prices_to_keep.value
}
output "history_combos_to_keep" {
  value = azurerm_key_vault_secret.history_combos_to_keep.value
}