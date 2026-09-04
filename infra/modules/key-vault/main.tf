resource "azurerm_key_vault" "this" {
  name                          = "kv-${var.name_prefix}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  enabled_for_disk_encryption   = false
  purge_protection_enabled      = true
  public_network_access_enabled = var.public_network_access_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  tags                          = var.tags
}

resource "azurerm_role_assignment" "secrets_user" {
  for_each = var.secrets_user_principal_ids

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value
}
