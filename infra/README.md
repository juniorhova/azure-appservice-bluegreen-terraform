# Infrastructure

Terraform code for the Azure App Service blue-green deployment reference
implementation will live here.

## Layout

```text
infra/
├── environments/
│   └── dev/
└── modules/
```

## Purpose

`environments/` contains deployable Terraform root modules. Each environment
owns provider configuration, backend configuration, environment-specific
variables, and module composition.

`modules/` contains reusable Terraform modules. Future modules are expected to
cover App Service, Key Vault, monitoring, and supporting Azure resources.

## Current Status

Scaffold only. No Azure resources are implemented yet.

## Remote State

The development environment is designed to use Azure Storage as the Terraform
remote backend. The backend storage account and container should be bootstrapped
before running `terraform init`.
