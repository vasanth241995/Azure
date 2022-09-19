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
variable "apim_name" {
  description = "API Manager name"
}
variable "creator" {
  description = "Creator"
}
variable "caper_exp_api_url" {
  description = "Caper Experience API URL"
}
variable "mastercard_experience_api_url" {
  description = "Mastercard Experience API URL"
}
variable "ngrp_auth_service_url" {
  description = "NGRP Auth Service URL"
}
variable "pdi_experience_api_url" {
  description = "PDI Experience API"
}
variable "ngrp_orchestrator_url" {
  description = "orchestrator url"
}
variable "publisher_name" {
  description = "publisher name"
}
variable "publisher_email" {
  description = "publisher email"
}
variable "sku_name" {
  description = "sku name"
}
variable "host_name" {
  description = "host name"
}
# variable "key_vault_id" {
#   description = "key vault id storing the certificate"
# }
variable "jwt_secret" {
  description = "jwt secret"
}
variable "certificate_key_vault_resource_group" {
  description = "certificate key vault resource group"
}
variable "certificate_key_vault_name" {
  description = "certificate key vault name"
}
variable "certificate_name" {
  description = "certificate name"
}
variable "store_service_url" {
  description = "store service url"
}
# variable "store_file_upload_depends_on" {
#   type = any
#   description = "store file upload policy should be reated after creating event topic subscriptions"
# }
variable "inventory_service_url" {
  description = "inventory service url"
}
