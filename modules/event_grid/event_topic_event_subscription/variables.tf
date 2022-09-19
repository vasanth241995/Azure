variable "event_subscription_name" {
  description = "Event subscription name"
}
variable "scope" {
  description = "Specifies the scope at which the EventGrid Event Subscription should be created."
}
variable "topic_name" {
  description = "Specifies the name of the topic to associate with the event subscription."
}
variable "webhook_endpoint_url" {
  description = "Specifies the url of the webhook where the Event Subscription will receive events."
}
variable "subject_begins_with" {
  description = "A string to filter events for an event subscription based on a resource path prefix."
}
variable "storage_account_id" {
  description = "Specifies the id of the storage account id where the storage blob is located."
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
variable "event_subscription_depends_on" {
  type = any
  description = "APIM Apis should be created before an event subscription"
}