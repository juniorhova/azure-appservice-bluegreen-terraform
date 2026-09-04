# Azure App Service Blue-Green Deployment with Terraform

Reference implementation scaffold for a production-minded Azure App Service
blue-green deployment using Terraform, deployment slots, Managed Identity,
Azure Key Vault, Application Insights, GitHub Actions, and remote Terraform
state in Azure Storage.

This repository is intended for public portfolio use. It uses placeholders and
does not contain real credentials, tenant IDs, subscription IDs, state files, or
customer-specific values.

## Project Status

Scaffold only. Terraform resources and application code are intentionally not
implemented yet.

## Target Architecture

```text
GitHub Actions
  |
  +--> Terraform with remote state in Azure Storage
  |      |
  |      +--> Resource Group
  |      +--> App Service Plan
  |      +--> App Service production slot
  |      +--> App Service staging slot
  |      +--> Key Vault
  |      +--> Application Insights
  |
  +--> Build sample web application
         |
         v
      Deploy to staging slot
         |
      Smoke tests
         |
      Slot swap
         |
         v
      Production slot
```

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── deploy.yml
│       ├── rollback.yml
│       └── terraform.yml
├── app/
│   └── README.md
├── docs/
│   ├── architecture.md
│   ├── deployment-flow.md
│   ├── rollback.md
│   └── security.md
├── infra/
│   ├── README.md
│   ├── environments/
│   │   └── dev/
│   │       ├── README.md
│   │       ├── backend.example.hcl
│   │       ├── backend.tf
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── terraform.tfvars.example
│   │       └── variables.tf
│   └── modules/
│       └── README.md
├── .gitignore
├── LICENSE
└── README.md
```

## Directory and File Purpose

`.github/workflows/` contains GitHub Actions workflow definitions.

`.github/workflows/terraform.yml` will validate, plan, and eventually apply the
Terraform configuration.

`.github/workflows/deploy.yml` will build the sample app, deploy it to the
staging slot, run smoke tests, and swap slots after validation.

`.github/workflows/rollback.yml` will provide a manual rollback workflow that
swaps the previous production version back into place.

`app/` will contain the small sample web application used to demonstrate the
deployment flow.

`app/README.md` explains the intended application responsibilities before code
is added.

`docs/` contains project documentation for architecture, deployment, rollback,
and security decisions.

`docs/architecture.md` describes the agreed Azure architecture and resource
boundaries.

`docs/deployment-flow.md` describes the expected CI/CD path from commit to slot
swap.

`docs/rollback.md` describes the slot-swap rollback approach.

`docs/security.md` documents public-repository safety, identity, secret
management, and Terraform state handling.

`infra/` contains Terraform source code and infrastructure documentation.

`infra/README.md` explains the infrastructure layout and implementation order.

`infra/modules/` is reserved for reusable Terraform modules. It is intentionally
empty except for documentation at this stage.

`infra/modules/README.md` describes the intended module boundaries.

`infra/environments/dev/` contains the development environment root module.

`infra/environments/dev/backend.tf` declares that the environment will use the
AzureRM remote backend. Backend values are supplied separately.

`infra/environments/dev/backend.example.hcl` provides placeholder backend
configuration for Azure Storage remote state.

`infra/environments/dev/main.tf` is the future entry point for composing
Terraform modules.

`infra/environments/dev/variables.tf` is reserved for environment input
variables.

`infra/environments/dev/outputs.tf` is reserved for environment outputs such as
App Service URLs.

`infra/environments/dev/terraform.tfvars.example` shows safe placeholder values
for local testing.

`.gitignore` blocks secrets, Terraform state, local environment files, and
generated Terraform working directories.

`LICENSE` defines the repository license.

## Security Baseline

Never commit real values for:

- Azure credentials
- Azure tenant IDs
- Azure subscription IDs
- Terraform state
- `.env` files
- Certificates or private keys
- Customer, employer, or production identifiers

Use placeholders such as:

```text
YOUR_SUBSCRIPTION_ID
YOUR_TENANT_ID
example.com
```

## Next Implementation Step

The next step is to define the Terraform module boundaries and development
environment variables before implementing any Azure resources.
