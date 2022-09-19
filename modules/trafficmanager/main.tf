resource "azurerm_traffic_manager_profile" "tm" {
  name                   = var.traffic_manager_name
  resource_group_name    = var.resource_group
  traffic_routing_method = "Weighted"
  dns_config {
    relative_name = "ngrp1"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
  tags = {
    Environment = var.environment
  }
}

/*
resource "azurerm_traffic_manager_endpoint" "tme" {
  name                = var.traffic_manager_endpoint
  resource_group_name = var.resource_group
  profile_name        = azurerm_traffic_manager_profile.tm.name
  target              = var.traffic_manager_endpoint_target
  type                = "externalEndpoints"
  weight              = 100
}*/

