# Infrastructure

Terraform code for the Azure App Service blue-green deployment reference
implementation.

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

`modules/` contains reusable Terraform modules for App Service, Key Vault,
monitoring, Resource Group, and supporting Azure resources.

## Current Status

The core Azure resources are implemented as reusable Terraform modules.

## Remote State

The development environment is designed to use Azure Storage as the Terraform
remote backend. The backend storage account and container should be bootstrapped
before running `terraform init`.

## Local Variable Files

Use `terraform.tfvars.example` as a public-safe template only. Copy its values
into a local `terraform.tfvars` file or pass them through environment variables
when testing locally. Real `terraform.tfvars` files are intentionally ignored by
Git.

## App Service Plan Quota

The default `S1` SKU is used because App Service deployment slots require a
slot-capable paid tier. Some Azure subscriptions have zero quota for `S1` App
Service workers in a given region. If Azure returns an error similar to
`Operation cannot be completed without additional quota`, use one of these
options:

1. Request quota for at least one `S1` App Service worker in the selected
   region.
2. Change `location` to a region where the subscription has App Service quota.
3. Change `app_service_plan_sku` to another slot-capable SKU with available
   quota, such as `S2`, `S3`, or a supported Premium v3 SKU.

Do not switch this blue-green reference implementation to `F1` or `B1` if the
staging slot is required.

If a failed apply already created partial resources in another region, run
`terraform plan` before applying again. Terraform may need to replace regional
resources when `location` changes.
