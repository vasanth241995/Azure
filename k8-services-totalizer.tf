resource "kubernetes_deployment" "services-totalizer-deployment" {
  metadata {
    name = "ngrp-services-totalizer-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-totalizer"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-totalizer"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-totalizer:${var.totalizer_service_image_tag}"
          name  = "services-totalizer"                   
         
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

resource "kubernetes_service" "services-totalizer" {
  metadata {
    name = "ngrp-services-totalizer-service"
  }
  spec {
    selector = {
      app = "services-totalizer"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = module.create_key_vault.deployment_type
  }
}
