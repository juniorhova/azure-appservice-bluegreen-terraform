# Deployment Flow

The deployment flow is split into two GitHub Actions workflows so
infrastructure and application changes can be reviewed, approved, and released
independently.

## Infrastructure Workflow

`.github/workflows/terraform.yml` runs when files under `infra/**` or the
workflow file itself change. It does not run for documentation-only changes.

Flow:

1. Checkout source.
2. Authenticate to Azure with GitHub OIDC federation.
3. Run `terraform fmt -check`.
4. Run `terraform init`.
5. Run `terraform validate`.
6. Run `terraform plan`.
7. Apply infrastructure only after the `azure-dev-infra` protected environment
   approval gate is satisfied.
8. Print useful Terraform output values to the workflow summary.

The workflow intentionally does not upload the generated Terraform plan file as
an artifact because plan files can contain sensitive values.

## Application Workflow

`.github/workflows/deploy.yml` runs when files under `app/**` or the workflow
file itself change. It does not run for documentation-only changes.

Flow:

1. Checkout source.
2. Install Node.js dependencies.
3. Run application tests.
4. Package the sample application.
5. Authenticate to Azure with GitHub OIDC federation.
6. Deploy the package to the staging App Service slot.
7. Run smoke tests against `/health` on the staging slot.
8. Swap staging into production only when smoke tests pass.
9. Run a production `/health` smoke test.
10. Print useful deployment information to the workflow summary.

Pull requests run validation only. Azure deployment runs on pushes to `main` or
manual `workflow_dispatch` runs.

## Required GitHub Configuration

Create these repository or environment variables. They are identifiers and
resource names, not long-lived secrets:

```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
TF_STATE_RESOURCE_GROUP_NAME
TF_STATE_STORAGE_ACCOUNT_NAME
TF_STATE_CONTAINER_NAME
TF_STATE_KEY
AZURE_RESOURCE_GROUP_NAME
AZURE_WEBAPP_NAME
AZURE_STAGING_URL
AZURE_PRODUCTION_URL
```

Create these protected environments:

```text
azure-dev-infra
azure-dev-app
```

Require reviewers on `azure-dev-infra` so Terraform apply cannot run until an
explicit approval is granted. Requiring reviewers on `azure-dev-app` is also
recommended for portfolio demos, especially before the slot swap step.

Configure the Azure federated identity credential on the service principal to
trust this GitHub repository and the branches/environments that are allowed to
deploy. This allows short-lived OIDC tokens instead of storing an Azure client
secret in GitHub.

## Validating Infrastructure Creation

Use this sequence to test the infrastructure:

```bash
cd infra/environments/dev

terraform init -backend-config=backend.example.hcl
terraform fmt -check -recursive ../..
terraform validate
terraform plan
terraform apply
terraform output
```

If App Service Plan creation fails with an Azure quota error, Terraform has
reached Azure successfully and Azure rejected the selected SKU. Request quota,
choose a region with available quota, or use another slot-capable SKU.
