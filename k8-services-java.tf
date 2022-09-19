# resource "kubernetes_deployment" "services-order-deployment" {
#   metadata {
#     name = "ngrp-service-order-deployment"    
#   }

#   spec {
#     replicas = "${module.create_key_vault.replica_count}"

#     selector {
#       match_labels = {
#         app = "java"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "java"
#         }
#       }

#       spec {
#         container {
#           image = "ngrpdemo.azurecr.io/ngrp-service-order:latest"
#           name  = "java"    

#           port{
#               container_port = 80
#           }
#         }
#         image_pull_secrets {
#           name = "regcred"
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "services-order" {
#   metadata {
#     name = "ngrp-service-order-service"
#   }
#   spec {
#     selector = {
#       app = "java"
#     }
    
#     port {
#       protocol    = "TCP"
#       port        = 8080
#       target_port = 8080
#     }

#     type = "LoadBalancer"
#   }
# }
