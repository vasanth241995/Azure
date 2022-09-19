resource "azurerm_eventgrid_topic" "event_topic" {
  name                = var.event_topic_name
  location            = var.location
  resource_group_name = var.resource_group

  tags = {
    Environment = var.environment
    Creator     = var.creator
  }
}