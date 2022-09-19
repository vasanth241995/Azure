provider "azurerm" {
  version         = "2.5.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features{}
}

provider "kubernetes" {
  version                 = "1.10.0"
  load_config_file        = "false"
  host                    = module.create_k8s_cluster.host
  username                = module.create_k8s_cluster.username
  password                = module.create_k8s_cluster.password
  client_certificate      = base64decode(module.create_k8s_cluster.client_certificate)
  client_key              = base64decode(module.create_k8s_cluster.client_key)
  cluster_ca_certificate  = base64decode(module.create_k8s_cluster.cluster_ca_certificate)
}