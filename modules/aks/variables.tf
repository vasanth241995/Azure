# Common Variables
variable "location" {
  description = "Azure location to deploy"
}
variable "environment" {
  description = "Specify the environment - dev/stg/prod"
}
variable "resource_group" {
  description = "Specify resource group"
}
variable "k8s_cluster_name" {
  description = "Kubernates cluster name"
}
variable "client_id" {
  description = "Azure client ID"
}
variable "client_secret" {
  description = "Azure client Secret"
}
variable "k8s_node_count" {
  description = "Kubernates node count"
}
variable "k8s_vm_size" {
  description = "Kubernates VM size"
}
variable "creator" {
  description = "Creator"
}

