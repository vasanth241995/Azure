output "primary_access_key" {
  value = azurerm_signalr_service.signalr.primary_access_key
}
output "primary_connection_string" {
  value = azurerm_signalr_service.signalr.primary_connection_string
}
output "secondary_access_key" {
  value = azurerm_signalr_service.signalr.secondary_access_key
}
output "secondary_connection_string" {
  value = azurerm_signalr_service.signalr.secondary_connection_string
}
output "signalr_name" {
  value = azurerm_signalr_service.signalr.name
}
output "signalr_url" {
  value = azurerm_signalr_service.signalr.hostname
}
