output "apim_gateway" {
  value = azurerm_api_management.apim.gateway_url
}

output "apim_object_id" {
  value = azurerm_api_management.apim.identity.0.principal_id
}

output "apim_tenant_id" {
  value = azurerm_api_management.apim.identity.0.tenant_id
}
