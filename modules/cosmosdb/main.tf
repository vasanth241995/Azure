resource "azurerm_cosmosdb_account" "cosmos" {
  name                = var.cosmos_account_name
  location            = var.location
  resource_group_name = var.resource_group
  offer_type          = "Standard"
  kind                = var.cosmos_db_kind
  #enable_multiple_write_locations  = var.enable_multi_master

  consistency_policy {
    consistency_level       = var.cosmos_consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  geo_location {
    prefix            = "${var.environment}-customid"
    location          = var.location
    failover_priority = 0
  }
  # geo_location {
  #   location          = var.failover_location
  #   failover_priority = 1
  # }

  tags = {
    Environment = var.environment
    Creator     = var.creator
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmos_db" {
  name                = var.cosmos_db_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  throughput          = var.cosmos_throughput

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_container" "customers_container" {
  name                = var.customers_container_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_db.name
  partition_key_path  = "/customerId"
  throughput          = var.cosmos_throughput

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }

  lifecycle {
    #prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_container" "orchestrations_container" {
  name                = var.orchestrations_container_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_db.name
  partition_key_path  = "/id"
  throughput          = var.cosmos_throughput

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }

  lifecycle {
    #prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_container" "reporting_container" {
  name                = var.reporting_container_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_db.name
  partition_key_path  = "/storeId"
  throughput          = var.cosmos_throughput

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }

  lifecycle {
    #prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_container" "identifiers_container" {
  name                = var.identifiers_container_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_db.name
  partition_key_path  = "/name"
  throughput          = var.cosmos_throughput

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }

  lifecycle {
    #prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_container" "offers_container" {
  name                = var.offers_container_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_db.name
  partition_key_path  = "/providerCode"
  throughput          = var.cosmos_throughput

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }

  lifecycle {
    #prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_container" "stores_container" {
  name                = var.stores_container_name
  resource_group_name = azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_db.name
  partition_key_path  = "/tenantCode"
  throughput          = var.cosmos_throughput

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }

  lifecycle {
    #prevent_destroy = true
  }
}