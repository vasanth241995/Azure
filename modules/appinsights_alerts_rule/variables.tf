variable "resource_group" {
  description = "Specify resource group"
}
variable "location" {
  description = "Azure location to deploy"
}
variable "app_insights_id" {
  description = "App Insights Id"
}
variable "action_group_id" {
  description = "Action group Id"
}
variable "alert_name" {
  description = "Alert name"
}
variable "alert_description" {
  description = "Alert description"
}
variable "alert_query" {
  description = "Alert query"
}
variable "alert_enabled" {
  description = "Enabled True or False"
}
variable "alert_severity" {
  description = "Alert severity"
}
variable "alert_frequency" {
  description = "Alert frequency"
}
variable "alert_time_window" {
  description = "Alert time window"
}
variable "alert_operator" {
  description = "Alert operator"
}
variable "alert_threshold" {
  description = "Alert threshold"
}