resource "azurerm_signalr_service" "signalr" {
  name                = var.signalr_name
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    name     = "Free_F1"
    capacity = 1
  }

  features {
    flag  = "ServiceMode"
    value = "Serverless"
  }
  features {
     flag  = "EnableConnectivityLogs"
     value = "True"
  }

  tags = {
    Environment = var.environment
    Creator     = var.creator
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}
