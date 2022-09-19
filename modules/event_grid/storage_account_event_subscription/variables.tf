variable "event_subscription_name" {
  description = "Event subscription name"
}
variable "storage_account_id" {
  description = "Specifies the scope at which the EventGrid Event Subscription should be created. Here storage_accont_id."
}
variable "functionapp_endpoint_base" {
  description = "The default hostname associated with the Function App"
}
variable "event_grid_function_name" {
  description = "Function App function name"
}
variable "function_host_key" {
  description = "Function App function host key"
}
variable "subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "file_dead_letter_conatiner_name" {
  description = "Specifies the name of the Storage blob container that is the destination of the deadletter events"
}
variable "max_delivery_attempts" {
  description = "Specifies the maximum number of delivery retry attempts for events."
}
variable "event_time_to_live" {
  description = "Specifies the time to live (in minutes) for events"
}
