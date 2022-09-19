resource "kubernetes_deployment" "services-pricebook-deployment" {
  metadata {
    name = "ngrp-services-pricebook-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-pricebook"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-pricebook"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-pricebook:${var.pricebook_service_image_tag}"
          name  = "services-pricebook"
                   
          env{
            name  = "pricebook.blob.storage.connection"
            value = module.create_key_vault.azure_connectstr
          }
          env{
            name  = "pricebook.blob.temp.storage.accountname"
            value = module.create_key_vault.pricebook_blob_temp_storage_accountname
          }
          env{
            name  = "pricebook.blob.temp.storage.accountkey"
            value = module.create_key_vault.pricebook_blob_temp_storage_accountkey
          }
          env{
            name  = "pricebook.blob.temp.storage.container"
            value = module.create_key_vault.pricebook_blob_temp_storage_container
          }
          env{
            name  = "pricebook.blob.server.storage.accountname"
            value = module.create_key_vault.pricebook_blob_server_storage_accountname
          }
          env{
            name  = "pricebook.blob.server.storage.accountkey"
            value = module.create_key_vault.pricebook_blob_server_storage_accountkey
          }
          env{
            name  = "pricebook.blob.server.storage.container"
            value = module.create_key_vault.pricebook_blob_server_storage_container
          }
          env{
            name  = "pricebook.azfun.signalr.url"
            value = module.create_key_vault.pricebook_azfun_signalr_url
          }
          env{
            name  = "pricebook.azfun.signalr.negotiate.key"
            value = module.create_key_vault.pricebook_azfun_signalr_negotiate_key
          }	
          env{
            name  = "pricebook.cache.maintenance.interval"
            value = module.create_key_vault.pricebook_cache_maintenance_interval
          }	
          env{
            name  = "pricebook.cache.maxsize"
            value = module.create_key_vault.pricebook_cache_max_size
          }	
          env{
            name  = "pricebook.cache.timeout"
            value = module.create_key_vault.pricebook_cache_timeout
          }	
          env{
            name  = "APPINSIGHTS_INSTRUMENTATIONKEY"
            value = module.create_key_vault.appinsightskey
          }
          env{
            name  = "authAction.jwt.secret"
            value = module.create_key_vault.jwt_secret
          } 
          env{
            name  = "JAVA_OPTS"
            value = "-Xms${module.create_key_vault.pricebook_memory_setting} -Xmx${module.create_key_vault.pricebook_memory_setting}"
          }

          liveness_probe {
            http_get {
              path = "/status"
              port = 8080
            }

            initial_delay_seconds = 20
            period_seconds        = 10
          }       

          port{
              container_port = 80
          }
        }
        image_pull_secrets {
          name = "regcred"
        }
      }
    }
  }
}

resource "kubernetes_service" "services-pricebook" {
  metadata {
    name = "ngrp-services-pricebook-service"
  }
  spec {
    selector = {
      app = "services-pricebook"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = module.create_key_vault.deployment_type
  }
}
