resource "kubernetes_deployment" "services-moneris-deployment" {
  metadata {
    name = "ngrp-services-moneris-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-moneris"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-moneris"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-moneris:${var.moneris_service_image_tag}"
          name  = "services-moneris"
                   
          env{
            name  = "db.driver"
            value = module.create_key_vault.mysql_db_driver
          }
          env{
            name  = "db.url"
            value = "${module.create_key_vault.mysql_db_url}/moneris?serverTimezone=UTC"
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
          env{
            name  = "SPRING_PROFILES_ACTIVE"
            value = module.create_key_vault.spring_profiles_active
          } 
          env{
            name  = "moneris.test-mode"
            value = module.create_key_vault.moneris_test_mode
          } 
          env{
            name  = "moneris.pre-auth-amount"
            value = module.create_key_vault.moneris_pre_auth_amount
          } 
          env{
            name  = "moneris.api-token"
            value = module.create_key_vault.moneris_api_token
          } 
          env{
            name  = "moneris.store-id"
            value = module.create_key_vault.moneris_store_id
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

resource "kubernetes_service" "services-moneris" {
  metadata {
    name = "ngrp-services-moneris-service"
  }
  spec {
    selector = {
      app = "services-moneris"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = module.create_key_vault.deployment_type
  }
}
