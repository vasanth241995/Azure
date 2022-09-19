resource "kubernetes_deployment" "services-tax-deployment" {
  metadata {
    name = "ngrp-services-tax-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-tax"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-tax"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-tax:${var.tax_service_image_tag}"
          name  = "services-tax"
                   
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

          image_pull_policy = "Always"    

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

resource "kubernetes_service" "services-tax" {
  metadata {
    name = "ngrp-services-tax-service"
  }
  spec {
    selector = {
      app = "services-tax"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = module.create_key_vault.deployment_type
  }
}
