resource "kubernetes_deployment" "services-orchestrator-deployment" {
  metadata {
    name = "ngrp-orchestrator-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "ngrp-orchestrator"
      }
    }

    template {
      metadata {
        labels = {
          app = "ngrp-orchestrator"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-orchestrator:${var.orchestrator_service_image_tag}"
          name  = "ngrp-orchestrator"
                   
          env{
            name  = "pricebook.url"
            value = module.create_key_vault.pricebook_service_url
          }
          env{
            name  = "report.url"
            value = module.create_key_vault.report_service_url
          }
          env{
            name  = "tax.url"
            value = module.create_key_vault.tax_service_url
          }
          env{
            name  = "totalizer.url"
            value = module.create_key_vault.totalizer_service_url
          }
          env{
            name  = "payment-orchestator.url"
            value = module.create_key_vault.orchestrator_base_url
          }
          env{
            name  = "moneris.url"
            value = module.create_key_vault.moneris_service_url
          }
          env{
            name  = "auth.url"
            value = module.create_key_vault.auth_service_url
          }
          env{
            name  = "customer.url"
            value = module.create_key_vault.customer_service_base_url
          }
          env{
            name  = "cosmosdb.db.id"
            value = module.create_key_vault.cosmos_db_id
          }
          env{
            name  = "cosmosdb.master_key"
            value = module.create_key_vault.reporting_key
          }
          env{
            name  = "cosmosdb.host"
            value = module.create_key_vault.cosmos_db_host
          }
          env{
            name  = "cosmosdb.container.id"
            value = module.create_key_vault.cosmos_db_container_id
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
            name  = "store.url"
            value = module.create_key_vault.store_service_url
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

resource "kubernetes_service" "services-orchestrator" {
  metadata {
    name = "ngrp-orchestrator-service"
  }
  spec {
    selector = {
      app = "ngrp-orchestrator"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
