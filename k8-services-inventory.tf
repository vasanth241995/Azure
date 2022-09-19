resource "kubernetes_deployment" "services-inventory-deployment" {
  metadata {
    name = "ngrp-services-inventory-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-inventory"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-inventory"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-inventory:${var.inventory_service_image_tag}"
          name  = "services-inventory"
                   
          env{
            name  = "db.driver"
            value = module.create_key_vault.mysql_db_driver
          }
          env{
            name  = "db.url"
            value = "${module.create_key_vault.mysql_db_url}/inventory?serverTimezone=UTC"
          }
          env{
            name  = "db.user"
            value = module.create_key_vault.mysql_db_username
          }
          env{
            name  = "db.pass"
            value = module.create_key_vault.mysql_db_password
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

resource "kubernetes_service" "services-inventory" {
  metadata {
    name = "ngrp-services-inventory-service"
  }
  spec {
    selector = {
      app = "services-inventory"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
