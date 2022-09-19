output "azure_connectionstring" {
  value = azurerm_storage_account.storageaccount.primary_connection_string
}
output "stroageaccount_name" {
  value = azurerm_storage_account.storageaccount.name
}
output "storageaccount_key" {
  value = azurerm_storage_account.storageaccount.primary_access_key
}
output "stroageaccount_id" {
  value = azurerm_storage_account.storageaccount.id
}