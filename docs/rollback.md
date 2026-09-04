# Rollback Strategy

Rollback will use Azure App Service slot swap.

After a successful swap, the previous production version remains in the staging
slot. If production verification fails, the rollback workflow will swap the
slots again to restore the previous production version.

The rollback workflow is intentionally manual in this scaffold.
