output "resource_group_name" {
  description = "Name of the workload resource group."
  value       = module.resource_group.name
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan."
  value       = module.app_service.app_service_plan_name
}

output "web_app_name" {
  description = "Name of the production Linux Web App."
  value       = module.app_service.web_app_name
}

output "web_app_default_hostname" {
  description = "Default hostname of the production Linux Web App."
  value       = module.app_service.web_app_default_hostname
}

output "web_app_url" {
  description = "HTTPS URL for the production Linux Web App."
  value       = module.app_service.web_app_url
}

output "staging_slot_name" {
  description = "Name of the staging deployment slot."
  value       = module.app_service.staging_slot_name
}

output "staging_slot_default_hostname" {
  description = "Default hostname of the staging deployment slot."
  value       = module.app_service.staging_slot_default_hostname
}

output "staging_slot_url" {
  description = "HTTPS URL for the staging deployment slot."
  value       = module.app_service.staging_slot_url
}

output "key_vault_name" {
  description = "Name of the Key Vault."
  value       = module.key_vault.name
}

output "application_insights_name" {
  description = "Name of the Application Insights resource."
  value       = module.monitoring.application_insights_name
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = module.monitoring.log_analytics_workspace_name
}
