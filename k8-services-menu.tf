resource "kubernetes_deployment" "services-menu-deployment" {
  metadata {
    name = "ngrp-services-menu-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-menu"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-menu"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-menu:${var.menu_service_image_tag}"
          name  = "services-menu"
                   
          env{
            name  = "menu.uri"
            value = module.create_key_vault.cosmos_db_host
          }
          env{
            name  = "menu.key"
            value = module.create_key_vault.reporting_key
          }
          env{
            name  = "menu.event.topic.endpoint"
            value = module.create_key_vault.menu_event_topic_endpoint
          }
          env{
            name  = "menu.event.topic.key"
            value = module.create_key_vault.menu_event_topic_key
          }
          env{
            name  = "history.prices.to.keep"
            value = module.create_key_vault.history_prices_to_keep
          }
          env{
            name  = "history.combos.to.keep"
            value = module.create_key_vault.history_combos_to_keep
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

resource "kubernetes_service" "services-menu" {
  metadata {
    name = "ngrp-services-menu-service"
  }
  spec {
    selector = {
      app = "services-menu"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = module.create_key_vault.deployment_type
  }
}
