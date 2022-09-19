resource "kubernetes_deployment" "services-exp-api-pdi-deployment" {
  metadata {
    name = "ngrp-exp-api-pdi-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "api-pdi"
      }
    }

    template {
      metadata {
        labels = {
          app = "api-pdi"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-exp-api-pdi:${var.api_pdi_service_image_tag}"
          name  = "api-pdi"               
          
          env{
            name  = "APPINSIGHTS_INSTRUMENTATIONKEY"
            value = module.create_key_vault.appinsightskey
          }
          env{
            name  = "ORCHESTRATOR_BASE_URL"
            value = module.create_key_vault.orchestrator_base_url
          }
          env{
            name  = "PRICEBOOK-BLOB-TEMP-STORAGE-ACCOUNTNAME"
            value = module.create_key_vault.pricebook_blob_temp_storage_accountname
          } 
          env{
            name  = "PRICEBOOK-BLOB-TEMP-STORAGE-SASKEY"
            value = module.create_key_vault.pricebook_blob_temp_storage_saskey
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

resource "kubernetes_service" "services-exp-api-pdi-api" {
  metadata {
    name = "ngrp-exp-api-pdi-api-service"
  }
  spec {
    selector = {
      app = "api-pdi"
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
