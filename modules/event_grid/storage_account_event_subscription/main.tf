resource "azurerm_eventgrid_event_subscription" "storage_account_event_subscription" {
  name  = var.event_subscription_name
  scope = var.storage_account_id
  event_delivery_schema = "EventGridSchema"
  included_event_types = ["Microsoft.Storage.BlobCreated"]

  webhook_endpoint {
    url = "https://${var.functionapp_endpoint_base}/runtime/webhooks/eventgrid?functionName=${var.event_grid_function_name}&code=${var.function_host_key}"
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
}