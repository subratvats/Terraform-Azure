resource "azurerm_resource_group" "resource_group" {
  name = "automation_new"
  location = "eastus2"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "automationnew748916"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  # depends_on = [ azurerm_resource_group.resource_group ]

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "container_name" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "blob"
}
resource "azurerm_storage_blob" "storage_blob" {
  name                   = "main.tf"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.container_name.name
  type                   = "Block"
  source                 = "main.tf"
}