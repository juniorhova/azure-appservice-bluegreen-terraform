output "app_service_plan_name" {
  description = "Name of the App Service Plan."
  value       = azurerm_service_plan.this.name
}

output "app_service_plan_id" {
  description = "Resource ID of the App Service Plan."
  value       = azurerm_service_plan.this.id
}

output "web_app_name" {
  description = "Name of the production Linux Web App."
  value       = azurerm_linux_web_app.this.name
}

output "web_app_id" {
  description = "Resource ID of the production Linux Web App."
  value       = azurerm_linux_web_app.this.id
}

output "web_app_default_hostname" {
  description = "Default hostname of the production Linux Web App."
  value       = azurerm_linux_web_app.this.default_hostname
}

output "web_app_url" {
  description = "HTTPS URL of the production Linux Web App."
  value       = "https://${azurerm_linux_web_app.this.default_hostname}"
}

output "staging_slot_name" {
  description = "Name of the staging deployment slot."
  value       = azurerm_linux_web_app_slot.staging.name
}

output "staging_slot_id" {
  description = "Resource ID of the staging deployment slot."
  value       = azurerm_linux_web_app_slot.staging.id
}

output "staging_slot_default_hostname" {
  description = "Default hostname of the staging deployment slot."
  value       = azurerm_linux_web_app_slot.staging.default_hostname
}

output "staging_slot_url" {
  description = "HTTPS URL of the staging deployment slot."
  value       = "https://${azurerm_linux_web_app_slot.staging.default_hostname}"
}

output "managed_identity_principal_ids" {
  description = "System-assigned managed identity principal IDs for production and staging slots."
  value = {
    production = azurerm_linux_web_app.this.identity[0].principal_id
    staging    = azurerm_linux_web_app_slot.staging.identity[0].principal_id
  }
}
