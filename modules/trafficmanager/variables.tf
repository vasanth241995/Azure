variable "location" {
  description = "Azure location to deploy"
}
variable "environment" {
  description = "Specify the environment - dev/stg/prod"
}
variable "resource_group" {
  description = "Specify resource group"
}
variable "traffic_manager_name" {
  description = "Traffic Manager Name"
}
/*
variable "traffic_manager_endpoint" {
  description = "Traffic Manager Endpoint"
}
variable "traffic_manager_endpoint_target" {
  description = "Traffic Manager Endpoint Target"
}*/

