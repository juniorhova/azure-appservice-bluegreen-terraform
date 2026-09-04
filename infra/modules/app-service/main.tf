locals {
  default_app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.application_insights_connection
    SCM_DO_BUILD_DURING_DEPLOYMENT        = "true"
  }

  app_settings = merge(local.default_app_settings, var.app_settings)
}

resource "azurerm_service_plan" "this" {
  name                = "asp-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                         = true
    ftps_state                        = "Disabled"
    health_check_eviction_time_in_min = var.health_check_eviction_time_in_min
    health_check_path                 = var.health_check_path
    minimum_tls_version               = "1.2"
    scm_minimum_tls_version           = "1.2"

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = local.app_settings

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}

resource "azurerm_linux_web_app_slot" "staging" {
  name           = "staging"
  app_service_id = azurerm_linux_web_app.this.id
  https_only     = true
  tags           = var.tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                         = true
    ftps_state                        = "Disabled"
    health_check_eviction_time_in_min = var.health_check_eviction_time_in_min
    health_check_path                 = var.health_check_path
    minimum_tls_version               = "1.2"
    scm_minimum_tls_version           = "1.2"

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = local.app_settings

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
