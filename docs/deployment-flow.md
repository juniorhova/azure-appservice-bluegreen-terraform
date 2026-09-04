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
