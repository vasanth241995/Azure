resource "kubernetes_deployment" "services-exp-api-order-deployment" {
  metadata {
    name = "ngrp-exp-api-order-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "api-order"
      }
    }

    template {
      metadata {
        labels = {
          app = "api-order"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-exp-api-order:${var.api_oder_service_image_tag}"
          name  = "api-order"               
          
          env{
            name  = "APPINSIGHTS_INSTRUMENTATIONKEY"
            value = module.create_key_vault.appinsightskey
          }
          env{
            name  = "ORCHESTRATOR_BASE_URL"
            value = module.create_key_vault.orchestrator_base_url
          }          
          env{
            name  = "authAction.jwt.secret"
            value = module.create_key_vault.jwt_secret
          }

          liveness_probe {
            http_get {
              path = "/status"
              port = 3000
            }

            initial_delay_seconds = 20
            period_seconds        = 10
          }

          image_pull_policy = "Always"      

          port{
              name = "port3000"
              container_port = 3000
          }

          port{
              name = "port8888"
              container_port = 8888
          }
        }
        image_pull_secrets {
          name = "regcred"
        }
      }
    }
  }
}

resource "kubernetes_service" "services-exp-api-order-api-service" {
  metadata {
    name = "ngrp-exp-api-order-api-service"
  }
  spec {
    selector = {
      app = "api-order"
    }
    
    port {
        name        = "port3000"
        protocol    = "TCP"
        port        = 3000
        target_port = 3000
    }

    port {
        name        = "port8888"
        protocol    = "TCP"
        port        = 8888
        target_port = 8888
    }

    type = "LoadBalancer"
  }
}
