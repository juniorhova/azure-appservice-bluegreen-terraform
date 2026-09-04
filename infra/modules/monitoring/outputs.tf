output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.this.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.this.id
}

output "application_insights_name" {
  description = "Name of the Application Insights resource."
  value       = azurerm_application_insights.this.name
}

output "application_insights_id" {
  description = "Resource ID of the Application Insights resource."
  value       = azurerm_application_insights.this.id
}

output "application_insights_connection_string" {
  description = "Application Insights connection string for application telemetry configuration."
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}
