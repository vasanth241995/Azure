output "mysql_url" {
  value = azurerm_mysql_server.mysqldb.fqdn
}
output "mysql_name" {
  value = azurerm_mysql_server.mysqldb.name
}
