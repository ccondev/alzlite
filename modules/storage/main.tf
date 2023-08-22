# Define an Azure Storage Account

resource "azurerm_storage_account" "st" {
  count                    = var.st_wk.st1.enable ? 1 : 0

  name                     = var.st_wk.st1.name
  resource_group_name      = var.st_wk.st1.resource_group_name
  location                 = var.st_wk.st1.location
  account_tier             = var.st_wk.st1.account_tier
  account_replication_type = var.st_wk.st1.account_replication_type
}