data "azurerm_client_config" "current" {}

locals {
  normalized_project     = lower(replace(var.project_name, "_", "-"))
  normalized_environment = lower(var.environment)
  normalized_suffix      = lower(var.resource_suffix)

  name_prefix           = "${local.normalized_project}-${local.normalized_environment}-${local.normalized_suffix}"
  key_vault_name_prefix = "${substr(replace(local.normalized_project, "-", ""), 0, 10)}-${local.normalized_environment}-${local.normalized_suffix}"

  common_tags = merge(
    var.tags,
    {
      project     = local.normalized_project
      environment = local.normalized_environment
      managed-by  = "terraform"
    }
  )
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.common_tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  name_prefix         = local.name_prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  retention_in_days   = var.log_retention_in_days
  tags                = local.common_tags
}

module "app_service" {
  source = "../../modules/app-service"

  name_prefix                       = local.name_prefix
  location                          = module.resource_group.location
  resource_group_name               = module.resource_group.name
  sku_name                          = var.app_service_plan_sku
  node_version                      = var.node_version
  health_check_path                 = var.health_check_path
  health_check_eviction_time_in_min = var.health_check_eviction_time_in_min
  application_insights_connection   = module.monitoring.application_insights_connection_string
  app_settings                      = var.app_settings
  tags                              = local.common_tags
}

module "key_vault" {
  source = "../../modules/key-vault"

  name_prefix                   = local.key_vault_name_prefix
  location                      = module.resource_group.location
  resource_group_name           = module.resource_group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  secrets_user_principal_ids    = module.app_service.managed_identity_principal_ids
  soft_delete_retention_days    = var.key_vault_soft_delete_retention_days
  public_network_access_enabled = var.key_vault_public_network_access_enabled
  tags                          = local.common_tags
}
