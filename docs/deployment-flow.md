# Deployment Flow

The intended deployment flow is:

1. Validate Terraform.
2. Plan infrastructure changes.
3. Apply approved infrastructure changes.
4. Build the sample application.
5. Deploy the application to the staging slot.
6. Run smoke tests against the staging slot.
7. Swap the staging slot into production.
8. Run production smoke tests.

The GitHub Actions workflows are placeholders until implementation begins.

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
