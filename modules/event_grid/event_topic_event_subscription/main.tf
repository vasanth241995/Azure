resource "azurerm_eventgrid_event_subscription" "custom_topic_event_subscription" {
  name  = var.event_subscription_name
  scope = var.scope
  event_delivery_schema = "EventGridSchema"
  included_event_types = ["Microsoft.Storage.BlobCreated"]
  topic_name = var.topic_name

  webhook_endpoint {
    url = var.webhook_endpoint_url
  }  

  subject_filter {
    subject_begins_with = var.subject_begins_with
  }

  storage_blob_dead_letter_destination {
    storage_account_id = var.storage_account_id
    storage_blob_container_name = var.file_dead_letter_conatiner_name
  }

  retry_policy {
    max_delivery_attempts = var.max_delivery_attempts
    event_time_to_live = var.event_time_to_live
  }
  
  depends_on = [var.event_subscription_depends_on]
}