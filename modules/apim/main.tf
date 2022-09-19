resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.resource_group
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = var.sku_name

  tags = {
    Environment = var.environment
    Creator     = var.creator
  }

  identity {
    type = "SystemAssigned"
  }

  # hostname_configuration {
  #   proxy {
  #     default_ssl_binding           = true
  #     host_name                     = var.host_name
  #     certificate                   = data.azurerm_key_vault_secret.certificate_key_vault_secret.value
  #     negotiate_client_certificate  = false      
  #   }
  # }

  lifecycle {
    prevent_destroy = true
  }
}

