# Development Environment

Terraform root module for the development environment.

## Purpose

This environment composes reusable modules from `infra/modules/` to deploy the
portfolio reference architecture into Azure.

## Files

`backend.tf` declares the AzureRM backend block. Values are supplied through
`backend.example.hcl` or equivalent CI/CD backend configuration.

`backend.example.hcl` contains public-safe placeholder values for Azure Storage
remote state.

`main.tf` composes the Resource Group, monitoring, App Service, and Key Vault
modules.

`variables.tf` defines validated environment input variables.

`outputs.tf` publishes environment outputs such as application URLs, resource
names, and smoke-test endpoints.

`terraform.tfvars.example` shows placeholder variable values. Do not commit
real `terraform.tfvars` files.

## Status

Development environment composition is implemented. Deployment still requires
safe backend configuration and caller-supplied Azure credentials.
