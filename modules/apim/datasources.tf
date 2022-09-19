# data "azurerm_key_vault" "common_key_vault" {
#   name                =  var.certificate_key_vault_name 
#   resource_group_name =  var.certificate_key_vault_resource_group
# }

# data "azurerm_client_config" "current" {}

# resource "azurerm_key_vault_access_policy" "key_vault_terraform_access_policy" {
#   key_vault_id  = data.azurerm_key_vault.common_key_vault.id
#   tenant_id     = data.azurerm_client_config.current.tenant_id
#   object_id     = data.azurerm_client_config.current.object_id

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

# data "azurerm_key_vault_secret" "certificate_key_vault_secret" {
#   name            = var.certificate_name
#   key_vault_id    = data.azurerm_key_vault.common_key_vault.id
#   # depends_on      = [azurerm_key_vault_access_policy.key_vault_terraform_access_policy]
# }