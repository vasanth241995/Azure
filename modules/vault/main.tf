data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                = "${var.prefix}-${var.environment}-vault"
  location            = var.location
  resource_group_name = var.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]

    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]

    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "932bc49b-6251-4c78-9f1a-14b534537b51" #ext_btemko@circlekna.com 

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]

    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]

    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }
  
  tags = {
    environment = var.environment
    Creator     = var.creator
  }

  lifecycle {
    prevent_destroy = true
  }
}

# ###SP Access policy
# resource "azurerm_key_vault_access_policy" "key_vault_sp_access_policy" {
#   key_vault_id = azurerm_key_vault.key_vault.id
#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = ""

#     certificate_permissions = [
#       "create",
#       "delete",
#       "deleteissuers",
#       "get",
#       "getissuers",
#       "import",
#       "list",
#       "listissuers",
#       "managecontacts",
#       "manageissuers",
#       "setissuers",
#       "update",
#     ]

#     key_permissions = [
#       "backup",
#       "create",
#       "decrypt",
#       "delete",
#       "encrypt",
#       "get",
#       "import",
#       "list",
#       "purge",
#       "recover",
#       "restore",
#       "sign",
#       "unwrapKey",
#       "update",
#       "verify",
#       "wrapKey",
#     ]

#     secret_permissions = [
#       "backup",
#       "delete",
#       "get",
#       "list",
#       "purge",
#       "recover",
#       "restore",
#       "set",
#     ]
# }

###Secrets
resource "azurerm_key_vault_secret" "replica_count" {
  name         = "REPLICA-COUNT"
  value        = "2"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "blob_report_container_name" {
  name         = "BLOB-REPORT-CONTAINER-NAME"
  value        = var.blob_report_container_name
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "azure_connectstr" {
  name         = "AZURE-CONNECTSTR"
  value        = var.azure_connectionstring_report
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "appinsightskey" {
  name         = "APPINSIGHTSKEY"
  value        = var.instrument_key
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "JWT-SECRET"
  value        = var.jwt_secret
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "reporting_uri" {
  name         = "REPORTING-URI"
  value        = var.cosmosdb_endpoint
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "reporting_key" {
  name         = "COSMOS-DB-MASTER-KEY"
  value        = var.cosmosdb_master_key
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mysql_db_driver" {
  name         = "MYSQL-DB-DRIVER"
  value        = "com.mysql.cj.jdbc.Driver"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mysql_db_url" {
  name         = "MYSQL-DB-URL"
  value        = "jdbc:mysql://${var.mysql_host}"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mysql_db_username" {
  name         = "MYSQL-DB-USERNAME"
  value        = "${var.prefix}-${var.environment}@${var.mysql_server_name}"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mysql_db_password" {
  name         = "MYSQL-DB-PASSWORD"
  value        = var.db_password
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "deployment_type" {
  name         = "DEPLOYMENT-TYPE"
  value        = "ClusterIP"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "docker_server" {
  name         = "DOCKER-SERVER"
  value        = var.acr_server
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "docker_email" {
  name         = "DOCKER-EMAIL"
  value        = var.acr_email
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "docker_username" {
  name         = "DOCKER-USERNAME"
  value        = var.acr_username
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "docker_password" {
  name         = "DOCKER-PASSWORD"
  value        = var.acr_pwd
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "orchestrator_base_url" {
  name         = "ORCHESTRATOR-BASE-URL"
  value        = "http://ngrp-orchestrator-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "customer_service_base_url" {
  name         = "CUSTOMER-SERVICE-BASE-URL"
  value        = "http://ngrp-customer-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mastercard_service_base_url" {
  name         = "MASTERCARD-SERVICE-BASE-URL"
  value        = "https://laas.labs.mastercard.com/shopanywhere/api/v2"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mastercard_auth_base_url" {
  name         = "MASTERCARD-AUTH-BASE-URL"
  value        = "https://laas.labs.mastercard.com/shopanywhere/api/v2"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mastercard_auth_name" {
  name         = "MASTERCARD-AUTH-NAME"
  value        = var.mastercard_auth_name
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mastercard_auth_password" {
  name         = "MASTERCARD-AUTH-PASSWORD"
  value        = var.mastercard_auth_pwd
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "mastercard_auth_tenant" {
  name         = "MASTERCARD-AUTH-TENANT"
  value        = var.mastercard_auth_tenant
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "thirdbridge_service_base_url" {
  name         = "THIRDBRIDGE-SERVICE-BASE-URL"
  value        = "couchetard"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_service_url" {
  name         = "PRICEBOOK-SERVICE-URL"
  value        = "http://ngrp-services-pricebook-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "report_service_url" {
  name         = "REPORT-SERVICE-URL"
  value        = "http://ngrp-services-reports-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "tax_service_url" {
  name         = "TAX-SERVICE-URL"
  value        = "http://ngrp-services-tax-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "totalizer_service_url" {
  name         = "TOTALIZER-SERVICE-URL"
  value        = "http://ngrp-services-totalizer-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "moneris_service_url" {
  name         = "MONERIS-SERVICE-URL"
  value        = "http://ngrp-services-moneris-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "auth_service_url" {
  name         = "AUTH-SERVICE-URL"
  value        = "http://ngrp-services-auth-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "cosmos_db_id" {
  name         = "COSMOS-DB-ID"
  value        = "ngrp"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "cosmos_db_host" {
  name         = "COSMOS-DB-HOST"
  value        = var.cosmosdb_endpoint
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "cosmos_db_container_id" {
  name         = "COSMOS-DB-CONTAINER-ID"
  value        = "orchestrations"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "spring_profiles_active" {
  name         = "SPRING-PROFILES-ACTIVE"
  value        = "dev"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "moneris_test_mode" {
  name         = "MONERIS-TEST-MODE"
  value        = "true"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "moneris_pre_auth_amount" {
  name         = "MONERIS-PRE-AUTH-AMOUNT"
  value        = "30.00"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "moneris_api_token" {
  name         = "MONERIS-API-TOKEN"
  value        = var.moneris_api_token
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "moneris_store_id" {
  name         = "MONERIS-STORE-ID"
  value        = var.moneris_store_id
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_container" {
  name         = "PRICEBOOK-BLOB-CONTAINER"
  value        = "pdi-blob-pricebooks"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_azfun_signalr_url" {
  name         = "PRICEBOOK-AZFUN-SIGNALR-URL"
  value        = "https://${var.pricebook_azfun_signalr_url}"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_azfun_signalr_negotiate_key" {
  name         = "PRICEBOOK-AZFUN-SIGNALR-NEGOTIATE-KEY"
  value        = var.pricebook_negotiate_function_key
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "signalr_url" {
  name         = "SIGNALR-URL"
  value        = var.signalr_conncetionstring
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_temp_storage_accountname" {
  name         = "PRICEBOOK-BLOB-TEMP-STORAGE-ACCOUNTNAME"
  value        = var.pricebook_blob_temp_storage_accountname
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_temp_storage_accountkey" {
  name         = "PRICEBOOK-BLOB-TEMP-STORAGE-ACCOUNTKEY"
  value        = var.pricebook_blob_temp_storage_accountkey
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_temp_storage_container" {
  name         = "PRICEBOOK-BLOB-TEMP-STORAGE-CONTAINER"
  value        = var.pricebook_blob_temp_storage_container
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_temp_storage_saskey" {
  name         = "PRICEBOOK-BLOB-TEMP-STORAGE-SASKEY"
  value        = var.pricebook_blob_temp_storage_saskey
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_server_storage_accountname" {
  name         = "PRICEBOOK-BLOB-SERVER-STORAGE-ACCOUNTNAME"
  value        = var.pricebook_blob_server_storage_accountname
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_server_storage_accountkey" {
  name         = "PRICEBOOK-BLOB-SERVER-STORAGE-ACCOUNTKEY"
  value        = var.pricebook_blob_server_storage_accountkey
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_blob_server_storage_container" {
  name         = "PRICEBOOK-BLOB-SERVER-STORAGE-CONTAINER"
  value        = var.pricebook_blob_server_storage_container
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
    Creator     = var.creator
  }
}
resource "azurerm_key_vault_secret" "store_service_url" {
  name         = "STORE-SERVICE-URL"
  value        = "http://ngrp-services-store-service:8080"
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_cache_maintenance_interval" {
  name         = "PRICEBOOK-CACHE-MAINTENANCE-INTERVAL"
  value        = var.pricebook_cache_maintenance_interval
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_cache_max_size" {
  name         = "PRICEBOOK-CACHE-MAXSIZE"
  value        = var.pricebook_cache_max_size
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_cache_timeout" {
  name         = "PRICEBOOK-CACHE-TIMEOUT"
  value        = var.pricebook_cache_timeout
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "pricebook_memory_setting" {
  name         = "PRICEBOOK-MEMORY-SETTING"
  value        = var.pricebook_memory_setting
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "menu_event_topic_endpoint" {
  name         = "MENU-EVENT-TOPIC-ENDPOINT"
  value        = var.menu_event_topic_endpoint
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "menu_event_topic_key" {
  name         = "MENU-EVENT-TOPIC-KEY"
  value        = var.menu_event_topic_key
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "history_prices_to_keep" {
  name         = "HISTORY-PRICES-TO-KEEP"
  value        = var.history_prices_to_keep
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}
resource "azurerm_key_vault_secret" "history_combos_to_keep" {
  name         = "HISTORY-COMBOS-TO-KEEP"
  value        = var.history_combos_to_keep
  key_vault_id = azurerm_key_vault.key_vault.id

  tags = {
    environment = var.environment
  }
}


