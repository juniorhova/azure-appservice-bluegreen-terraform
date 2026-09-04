# Rollback Strategy

Rollback uses Azure App Service slot swap.

After a successful swap, the previous production version remains in the staging
slot. If production verification fails, the rollback workflow will swap the
slots again to restore the previous production version.

`.github/workflows/rollback.yml` is intentionally manual. It authenticates to
Azure with GitHub OIDC federation, waits for the `azure-dev-app` protected
environment gate, swaps the staging slot back into production, and verifies
`/health` on the production URL.

Required variables:

```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
AZURE_RESOURCE_GROUP_NAME
AZURE_WEBAPP_NAME
AZURE_PRODUCTION_URL
```
