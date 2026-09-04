variable "name_prefix" {
  description = "Shared naming prefix for Key Vault resources. Combined with kv- and must satisfy Key Vault naming limits."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,21}$", var.name_prefix))
    error_message = "name_prefix must be 3-21 characters and contain only lowercase letters, numbers, and hyphens so kv-name fits Azure Key Vault limits."
  }
}

variable "location" {
  description = "Azure region for Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where Key Vault is deployed."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID for the Key Vault, read from the authenticated Azure provider context."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.tenant_id))
    error_message = "tenant_id must be a valid GUID."
  }
}

variable "secrets_user_principal_ids" {
  description = "Map of principal IDs granted Key Vault Secrets User on this vault."
  type        = map(string)

  validation {
    condition     = length(var.secrets_user_principal_ids) > 0
    error_message = "secrets_user_principal_ids must contain at least one principal ID."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted Key Vault objects are retained."
  type        = number

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for Key Vault."
  type        = bool
}

variable "tags" {
  description = "Tags applied to Key Vault."
  type        = map(string)
  default     = {}
}
