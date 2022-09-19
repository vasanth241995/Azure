variable "mysql_server_name" {
  description = "MySQL server name"
}
variable "db_username" {
  description = "MySQL DB username"
}
variable "db_password" {
  description = "MySQL DB password"
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
variable "sku_name" {
  description = "Specify sku name"
}
variable "creator" {
  description = "Creator"
}

