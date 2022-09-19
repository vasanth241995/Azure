output "cosmos-db-id" {
  value = azurerm_cosmosdb_account.cosmos.id
}

output "cosmos-db-endpoint" {
  value = azurerm_cosmosdb_account.cosmos.endpoint
}

output "cosmos-db-endpoints_read" {
  value = azurerm_cosmosdb_account.cosmos.read_endpoints
}

output "cosmos-db-endpoints_write" {
  value = azurerm_cosmosdb_account.cosmos.write_endpoints
}

output "cosmos-db-primary_master_key" {
  value = azurerm_cosmosdb_account.cosmos.primary_master_key
}

output "cosmos-db-secondary_master_key" {
  value = azurerm_cosmosdb_account.cosmos.secondary_master_key
}
