resource "kubernetes_deployment" "services-reports-deployment" {
  metadata {
    name = "ngrp-services-reports-deployment"    
  }

  spec {
    replicas = module.create_key_vault.replica_count

    selector {
      match_labels = {
        app = "services-reports"
      }
    }

    template {
      metadata {
        labels = {
          app = "services-reports"
        }
      }

      spec {
        container {
          image = "ngrpdevregistry.azurecr.io/ngrp-services-reports:${var.report_service_image_tag}"
          name  = "services-reports"

          env {
            name  = "blob.report_container_name"
            value = module.create_key_vault.blob_report_container_name
          }
          env{
            name  = "azure.connectStr"
            value = module.create_key_vault.azure_connectstr
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
            name  = "reporting.uri"
            value = module.create_key_vault.reporting_uri
          }
          env{
            name  = "reporting.key"
            value = module.create_key_vault.reporting_key
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

resource "kubernetes_service" "services-reports" {
  metadata {
    name = "ngrp-services-reports-service"
  }
  spec {
    selector = {
      app = "services-reports"
    }
    
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }

    type = module.create_key_vault.deployment_type
  }
}
