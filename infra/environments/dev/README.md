# Development Environment

Terraform root module for the development environment.

## Purpose

This environment will compose reusable modules from `infra/modules/` to deploy
the portfolio reference architecture into Azure.

## Files

`backend.tf` declares the AzureRM backend block. Values are supplied through
`backend.example.hcl` or equivalent CI/CD backend configuration.

`backend.example.hcl` contains public-safe placeholder values for Azure Storage
remote state.

`main.tf` is the future module composition entry point.

`variables.tf` is reserved for environment input variables.

`outputs.tf` is reserved for environment outputs such as application URLs,
resource names, and smoke-test endpoints.

`terraform.tfvars.example` shows placeholder variable values. Do not commit
real `terraform.tfvars` files.

## Status

Scaffold only. No Azure resources are implemented yet.
