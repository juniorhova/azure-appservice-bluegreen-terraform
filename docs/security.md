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

## Security Design

- GitHub Actions authenticates to Azure using OpenID Connect.
- App Service reads secrets from Key Vault using Managed Identity.
- Terraform state is stored remotely in Azure Storage.
- Real environment values are supplied through local ignored files or CI/CD
  variables.

## CI/CD Security Decisions

- Workflows grant `permissions: id-token: write` only to jobs that authenticate
  to Azure so GitHub can request a short-lived OIDC token.
- No Azure client secret, publish profile, or long-lived service principal
  password is stored in GitHub.
- Terraform apply is separated from plan by the `azure-dev-infra` protected
  environment approval gate.
- Application deployment and rollback use the `azure-dev-app` environment so
  release permissions can be managed separately from infrastructure permissions.
- Terraform plan files are not uploaded as artifacts because they may include
  sensitive values from providers, variables, or resource attributes.
- Workflow triggers are path-scoped: infrastructure changes trigger only the
  infrastructure workflow, application changes trigger only the application
  workflow, and documentation-only changes do not start deployments.
