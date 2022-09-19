output "instrumentation_key" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}
output "app_id" {
  value = azurerm_application_insights.appinsights.app_id
}
output "app_insight_id" {
  value = azurerm_application_insights.appinsights.id
}
output "action_group_id" {
  value = azurerm_monitor_action_group.action-grp.id
}