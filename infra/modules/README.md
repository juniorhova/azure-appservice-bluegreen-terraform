# Terraform Modules

Reusable Terraform modules for the Azure App Service blue-green reference
architecture.

## Modules

- `resource-group`: Resource Group boundary for the reference environment.
- `app-service`: App Service Plan, Linux Web App, staging slot, and managed
  identity configuration.
- `key-vault`: Key Vault configuration and access for App Service managed
  identities.
- `monitoring`: Log Analytics Workspace and Application Insights.

Each module keeps provider configuration out of the module boundary so root
modules can control authentication, backend configuration, and environment-level
settings.
