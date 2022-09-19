resource "kubernetes_deployment" "services-auth-deployment" {
  metadata {
    name = "ngrp-services-auth-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-auth"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-auth"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-auth:${var.auth_service_image_tag}"
          name  = "services-auth"                   
          
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

resource "kubernetes_service" "services-auth" {
  metadata {
    name = "ngrp-services-auth-service"
  }
  spec {
    selector = {
      app = "services-auth"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
