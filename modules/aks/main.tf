resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.k8s_cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "ngrp"

  default_node_pool {
    name                  = "default"
    node_count            = var.k8s_node_count
    vm_size               = var.k8s_vm_size
    enable_auto_scaling   = true
    max_count             = 99
    min_count             = 2  
  }  

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = var.environment
    Creator     = var.creator
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [ default_node_pool.0.node_count ]
  }
}

