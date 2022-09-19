### Auth variables #values from ngrpdevregsp
subscription_id       = "#{subscription-id}#"
client_id             = "#{client-id}#"
client_secret         = "#{client-secret}#"
tenant_id             = "#{tenant-id}#"

### App access permission
app_tenant_id = ""
app_object_id = ""

### Common variables
location              = "eastus" /* Azure region code to deploy */
location_name         = "East US" /* Azure region name to deploy */
prefix                = "ngrp"
environment           = "terra-dev" /* Specify the environment - dev/stg/prod */
resource_group        = "Terraform-Dev"
common_resource_group = "Terraform-Dev"
creator               = "Rocket"

### Cluster Variables
k8s_node_count        = "2"
k8s_vm_size           = "Standard_DS2_v2"

### MySQL variables
db_password           = "#{MYSQL-DB-PASSWORD}#"
mysql_sku_name        = "B_Gen5_2"

### Server Storage Account variables
storage_account_name_server = "ngrptdevstorage"
account_tier_server = "Standard"
account_replication_type_server = "ZRS"
account_kind_server = "StorageV2"
# Priebook Container
container_name_pricebook = "pricebooks"
access_type_pricebook = "container"
# Cardinfo Container
container_name_cardinfo = "cardinfo"
access_type_cardinfo = "container"
# Reports Container
container_name_report = "reports"
access_type_report = "container"

### temp Storage Account variables
storage_account_name_temp = "ngrptemptdevstorage"
account_tier_temp = "Standard"
account_replication_type_temp = "ZRS"
account_kind_temp = "StorageV2"
# Temp Container
container_name_temp = "temp"
access_type_temp = "container"
delete_temp_blob_after_days = "1"

###Azure Function App variables
fnapp_appservice_sku_tier = "Basic"
fnapp_appservice_sku_size = "B1"


# Azure Function Storage Account variables
storage_account_name_azurefn = "stazurefntdev"
account_tier_azurefn = "Standard"
account_replication_type_azurefn = "LRS"
account_kind_azurefn = "StorageV2"
container_name_azurefn= "azure-function"
access_type_azurefn = "container"

### Service-deployment variables
report_service_image_tag = "11220"                  #ngrp-services-reports
costumer_service_image_tag = "11221"                #ngrp-services-customer
api_mastercard_service_image_tag = "11219"          #ngrpdemo.azurecr.io/mastercard-shop-anywhere-spec
# api_offer_service_image_tag = "8523" 
api_oder_service_image_tag = "11222"                #ngrp-exp-api-order
api_pdi_service_image_tag = "11223"                 #ngrp-exp-api-pdi
orchestrator_service_image_tag = "11430"            #ngrp-orchestrator
auth_service_image_tag = "11225"                    #ngrp-services-auth
moneris_service_image_tag = "11227"                 #ngrp-services-moneris
pricebook_service_image_tag = "13860"               #ngrp-services-pricebook
tax_service_image_tag = "11859"                     #ngrp-services-tax
totalizer_service_image_tag = "11230"               #ngrp-services-totalizer
fnapp_image_tag = "11231"                           #ngrp-functions-pricebook
store_service_image_tag = "13238"                   #ngrp-services-store
inventory_service_image_tag = "13628"               #ngrp-services-inventory
menu_service_image_tag = "14177"                    #ngrp-services-menu

### Signal R Servie Variables
signalr_azure_location = "eastus"

### Production COntainer Registry
#prod_container_registry_name = "ngrpprodregistry"

### Cosmos variables
cosmos_consistency_level = "BoundedStaleness"
cosmos_db_name = "ngrp"
cosmos_throughput = 1000
customers_container_name = "customers"
orchestrations_container_name = "orchestrations"
reporting_container_name = "reporting"
identifiers_container_name = "identifiers"
offers_container_name = "offers"
stores_container_name = "stores"
#enable_multi_master = true
#failover_location = "eastus2"
cosmos_db_kind = "GlobalDocumentDB"
max_interval_in_seconds = 310
max_staleness_prefix = 100001

###API Management variables
apim_publisher_name = "NGRP"
apim_publisher_email = "ngrp@example.io"
apim_sku_name   = "Developer_1"
apim_host_name  = "t-dev.test.circlek-api.com"
# apim_key_vault_id = "https://ngrp-prod-common-vault.vault.azure.net/secrets/NGRP-Star-Dot-Prod-Certificate/dcfdde58ccee472c82aab6288bb3692f"
certificate_key_vault_resource_group = "ngrp-dev"
certificate_key_vault_name  = "ngrp-api-demo"
certificate_name    = "terra-dev"

###Key-Vault Variable
key_vault_sku_name = "standard"
jwt_secret = "#{JWT-SECRET}#"
acr_server = "#{ACR-DEV-SERVER}#"
acr_email = "#{ACR-DEV-EMAIL}#"
acr_username = "#{ACR-DEV-USER-NAME}#"
acr_pwd = "#{ACR-DEV-PWD}#"
mastercard_auth_name = "#{MASTERCARD-AUTH-NAME}#"
mastercard_auth_pwd = "#{MASTERCARD-AUTH-PASSWORD}#"
mastercard_auth_tenant = "#{MASTERCARD-AUTH-TENANT}#"
moneris_api_token = "#{MONERIS-API-TOKEN}#"
moneris_store_id = "#{MONERIS-STORE-ID}#"
pricebook_negotiate_function_key = "#{PRICEBOOK-AZFUN-SIGNALR-NEGOTIATE-KEY}#"
history_prices_to_keep = "3"
history_combos_to_keep = "3"

###App Insights Variables
action_group_short_name = "tdevgrp"
webhook_receiver_url = "#{PAGERDUTY-INTEGRATION-URL}#"

### Storage account event grid subscription
storage_account_event_subscription_name = "file-announce"
storage_account_subject_begins_with = "/blobServices/default/containers/files/blobs/"
storage_account_max_delivery_attempts = 30
storage_account_event_time_to_live = 1440

###Event grid
files_conatiner_name = "files"
files_conatiner_access = "private" 

file_dead_letter_conatiner_name = "filedeadletterqueue"
file_dead_letter_conatiner_access = "private" 

### Custom event grid Topic subscriptions - store Mcgill
mcgill_event_subscription_name = "store-file-mcgill"
mcgill_subject_begins_with = "/blobServices/default/containers/files/blobs/mcgill/taxes"
mcgill_max_delivery_attempts = 30
mcgill_event_time_to_live = 1440
mcgill_webhook_token = "#{STORE-SERVICE-WEBHOOK-JWT-MCGILL}#"

### Custom event grid Topic subscriptions - store Cirlek-US
circlek_us_event_subscription_name = "store-file-CIRCLEK-US"
circlek_us_subject_begins_with = "/blobServices/default/containers/files/blobs/circlek-us/taxes"
circlek_us_max_delivery_attempts = 30
circlek_us_event_time_to_live = 1440
circlek_us_webhook_token = "#{STORE-SERVICE-WEBHOOK-JWT-CIRCLEK-US}#"

### Custom event grid Topic subscriptions - inventory Mcgill
mcgill_inventory_event_subscription_name = "inventory-file-mcgill"
mcgill_inventory_subject_begins_with = "/blobServices/default/containers/files/blobs/mcgill/inventory"
mcgill_inventory_max_delivery_attempts = 3
mcgill_inventory_event_time_to_live = 60
mcgill_inventory_webhook_token = "#{INVENTORY-SERVICE-WEBHOOK-JWT-MCGILL}#"

### Custom event grid Topic subscriptions - inventory Cirlek-US
circlek_us_inventory_event_subscription_name = "inventory-file-CIRCLEK-US"
circlek_us_inventory_subject_begins_with = "/blobServices/default/containers/files/blobs/circlek-us/inventory"
circlek_us_inventory_max_delivery_attempts = 3
circlek_us_inventory_event_time_to_live = 60
circlek_us_inventory_webhook_token = "#{INVENTORY-SERVICE-WEBHOOK-JWT-CIRCLEK-US}#"

###azure File Announce function variables
file_fnapp_image_tag = "13173"
file_storage_account_name_azurefn = "stfileazfntdev"
file_account_tier_azurefn = "Standard"
file_account_replication_type_azurefn = "LRS"
file_account_kind_azurefn = "StorageV2"
file_container_name_azurefn = "azure-function"
file_access_type_azurefn = "container"

###Pricebook settings
pricebook_cache_maintenance_interval      = "10"
pricebook_cache_max_size                  = "2000"
pricebook_cache_timeout                   = "36"
pricebook_memory_setting                  = "3g"
