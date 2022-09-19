resource "azurerm_monitor_scheduled_query_rules_alert" "query-alert-rule" {
  name                  = var.alert_name
  location              = var.location
  resource_group_name   = var.resource_group

  action {
    action_group        = [var.action_group_id]
  }

  data_source_id        = var.app_insights_id
  description           = var.alert_description
  enabled               = var.alert_enabled

  query                 = var.alert_query 

  severity              = var.alert_severity
  frequency             = var.alert_frequency
  time_window           = var.alert_time_window
  trigger {
    operator            = var.alert_operator
    threshold           = var.alert_threshold
  }
}