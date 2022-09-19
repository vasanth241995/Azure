resource "azurerm_mysql_server" "mysqldb" {
  name                = var.mysql_server_name
  location            = var.location
  resource_group_name = var.resource_group

  sku_name            = var.sku_name

  storage_profile {
    storage_mb            = 102400
    backup_retention_days = 35
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = var.db_username
  administrator_login_password = var.db_password
  version                      = "5.7"
  ssl_enforcement              = "Disabled"
  tags = {
    Environment = var.environment
    Creator     = var.creator
  }

  lifecycle {
    prevent_destroy = true
  }

}

resource "azurerm_mysql_firewall_rule" "mysql_fw" {
  name                = "office"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysqldb.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mysql_configuration" "mysql_log_bin" {
  name                = "log_bin_trust_function_creators"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysqldb.name
  value               = "ON"
}
