output "event_topic_id" {
  value = azurerm_eventgrid_topic.event_topic.id
}
output "event_topic_endpoint" {
  value = azurerm_eventgrid_topic.event_topic.endpoint
}
output "event_topic_access_key" {
  value = azurerm_eventgrid_topic.event_topic.primary_access_key
}