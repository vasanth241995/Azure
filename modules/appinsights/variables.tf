variable "appinsights_name" {
  description = "App Insights name"
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
variable "action_group_name" {
  description = "action group name"
}
variable "action_group_short_name" {
  description = "action group short name"
}
variable "webhook_receiver_name" {
  description = "webhook receiver name"
}
variable "webhook_receiver_url" {
  description = "webhook receiver url"
}