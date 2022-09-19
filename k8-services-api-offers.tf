# resource "kubernetes_deployment" "services-exp-api-offers-deployment" {
#   metadata {
#     name = "ngrp-exp-api-offers-deployment"    
#   }

#   spec {
#     replicas = "${module.create_key_vault.replica_count}"

#     selector {
#       match_labels = {
#         app = "api-offers"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "api-offers"
#         }
#       }

#       spec {
#         container {
#           image = "ngrpdevregistry.azurecr.io/ngrp-exp-api-offers:${var.api_offer_service_image_tag}"
#           name  = "api-offers"
                   
#           env{
#             name  = "APP_INSIGHTS_KEY"
#             value = "${module.create_key_vault.appinsightskey}"
#           }
#           env{
#             name  = "ORCHESTRATOR_BASE_URL"
#             value = "${module.create_key_vault.jwt_secret}"
#           }          
#           env{
#             name  = "authAction.jwt.secret"
#             value = "${module.create_key_vault.jwt_secret}"
#           }
          
#           image_pull_policy = "Always"

#           port{
#               container_port = 3000
#           }
#         }
#         image_pull_secrets {
#           name = "regcred"
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "services-exp-api-offers" {
#   metadata {
#     name = "ngrp-exp-api-offers-service"
#   }
#   spec {
#     selector = {
#       app = "api-offers"
#     }
    
#     port {
#       protocol    = "TCP"
#       port        = 3000
#       target_port = 3000
#     }

#     type = "LoadBalancer"
#   }
# }
