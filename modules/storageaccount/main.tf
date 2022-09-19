resource "azurerm_storage_account" "storageaccount" {
  name                     = var.stroageaccount_name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.tier
  account_replication_type = var.repli_type
  account_kind             = var.repli_kind

  tags = {
    environment = var.environment
    Creator     = var.creator
  }

  lifecycle {
    prevent_destroy = true
  }
}
