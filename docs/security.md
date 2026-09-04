# Security

This repository is designed to be safe for public GitHub publishing.

## Rules

Do not commit:

- Real Azure credentials
- Tenant IDs that should remain private
- Subscription IDs that should remain private
- Terraform state
- `.env` files
- Certificates or private keys
- Customer names
- Employer internal URLs
- Production IP addresses

## Planned Security Design

- GitHub Actions authenticates to Azure using OpenID Connect.
- App Service reads secrets from Key Vault using Managed Identity.
- Terraform state is stored remotely in Azure Storage.
- Real environment values are supplied through local ignored files or CI/CD
  variables.
