resource "azurerm_monitor_action_group" "action-grp" {
  name                = var.action_group_name
  resource_group_name = var.resource_group
  short_name          = var.action_group_short_name
  
  webhook_receiver {
    name                    = var.webhook_receiver_name
    service_uri             = var.webhook_receiver_url
    use_common_alert_schema = false
  }
}