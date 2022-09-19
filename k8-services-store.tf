resource "kubernetes_deployment" "services-store-deployment" {
  metadata {
    name = "ngrp-services-store-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-store"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-store"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-store:${var.store_service_image_tag}"
          name  = "services-store"
                   
          env{
            name  = "store.uri"
            value = module.create_key_vault.cosmos_db_host
          }
          env{
            name  = "store.key"
            value = module.create_key_vault.reporting_key
          }
          env{
            name  = "APPINSIGHTS_INSTRUMENTATIONKEY"
            value = module.create_key_vault.appinsightskey
          }
          env{
            name  = "authAction.jwt.secret"
            value = module.create_key_vault.jwt_secret
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
              container_port = 8080
          }
        }
        image_pull_secrets {
          name = "regcred"
        }
      }
    }
  }
}

resource "kubernetes_service" "services-store" {
  metadata {
    name = "ngrp-services-store-service"
  }
  spec {
    selector = {
      app = "services-store"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
