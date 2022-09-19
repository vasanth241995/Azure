resource "kubernetes_deployment" "services-exp-api-mastercard-shop-anywhere-deployment" {
  metadata {
    name = "ngrp-exp-api-mastercard-shop-anywhere-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "api-mastercard"
      }
    }

    template {
      metadata {
        labels = {
          app = "api-mastercard"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrpdemo.azurecr.io/mastercard-shop-anywhere-spec:${var.api_mastercard_service_image_tag}"
          name  = "api-mastercard"               
          
          env{
            name  = "APPINSIGHTS_INSTRUMENTATIONKEY"
            value = module.create_key_vault.appinsightskey
          }
          env{
            name  = "ORCHESTRATOR_BASE_URL"
            value = module.create_key_vault.orchestrator_base_url
          }   
           env{
            name  = "PAYMENT_ORCHESTRATOR_BASE_URL"
            value = module.create_key_vault.orchestrator_base_url
          }
          env{
            name  = "CUSTOMER_SERVICE_BASE_URL"
            value = module.create_key_vault.customer_service_base_url
          }
          env{
            name  = "MASTERCARD_SERVICE_BASE_URL"
            value = module.create_key_vault.mastercard_service_base_url
          }
          env{
            name  = "MASTERCARD_AUTH_BASE_URL"
            value = module.create_key_vault.mastercard_auth_base_url
          }
          env{
            name  = "MASTERCARD_AUTH_NAME"
            value = module.create_key_vault.mastercard_auth_name
          }
          env{
            name  = "MASTERCARD_AUTH_PASSWORD"
            value = module.create_key_vault.mastercard_auth_password
          }
          env{
            name  = "MASTERCARD_AUTH_TENANT"
            value = module.create_key_vault.mastercard_auth_tenant
          }
          env{
            name  = "THIRDBRIDGE_SERVICE_BASE_URL"
            value = module.create_key_vault.thirdbridge_service_base_url
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

resource "kubernetes_service" "services-exp-api-mastercard-shop-anywhere" {
  metadata {
    name = "ngrp-exp-api-mastercard-shop-anywhere-service"
  }
  spec {
    selector = {
      app = "api-mastercard"
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
