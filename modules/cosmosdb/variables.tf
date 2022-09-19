variable "cosmos_account_name" {
  description = "Cosmos DB account name"
}
variable "location" {
  description = "Azure location to deploy"
}
variable "environment" {
  description = "Specify the environment - dev/stg/prod"
}
variable "resource_group" {
  description = "Specify resource group"
}
variable "creator" {
  description = "Creator"
}
variable "cosmos_consistency_level" {
  description = "Cosmos consistency level"
}
variable "cosmos_db_name" {
  description = "Cosmos DB name"
}
variable "cosmos_throughput" {
  description = "Cosmos DB throughput"
}
variable "customers_container_name" {
  description = "customers container name"
}
variable "orchestrations_container_name" {
  description = "orchestrations container name"
}
variable "reporting_container_name" {
  description = "reporting container name"
}
# variable "enable_multi_master" {
#   description = "enable multi master"
# }
# variable "failover_location" {
#   description = "The name of the Azure region to host replicated data"
# }
variable "cosmos_db_kind" {
  description = "Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB"
}
variable "max_interval_in_seconds" {
  description = "max interval in seconds"
}
variable "max_staleness_prefix" {
  description = "max staleness prefix"
}
variable "identifiers_container_name" {
  description = "identifiers container name"
}
variable "offers_container_name" {
  description = "offers container name"
}
variable "stores_container_name" {
  description = "stores container name"
}

