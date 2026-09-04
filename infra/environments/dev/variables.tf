variable "subscription_id" {
  description = "Azure subscription ID used by the AzureRM provider. Supply this from local environment variables or CI/CD configuration."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "subscription_id must be a valid Azure subscription GUID."
  }
}

variable "location" {
  description = "Azure region where the workload resources are deployed."
  type        = string
  default     = "eastus"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location cannot be empty."
  }
}

variable "environment" {
  description = "Short environment name used for resource naming and tags."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z0-9-]{2,12}$", var.environment))
    error_message = "environment must be 2-12 characters and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "project_name" {
  description = "Project name used as part of Azure resource names."
  type        = string
  default     = "appservice-bluegreen"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{3,30}$", var.project_name))
    error_message = "project_name must be 3-30 characters and contain only letters, numbers, hyphens, or underscores."
  }
}

variable "resource_suffix" {
  description = "Short suffix used to reduce Azure global name collisions. Use a non-sensitive value, not an account ID."
  type        = string
  default     = "demo"

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.resource_suffix))
    error_message = "resource_suffix must be 3-8 lowercase letters or numbers."
  }
}

variable "app_service_plan_sku" {
  description = "App Service Plan SKU. Use S1 or higher for deployment slot support."
  type        = string
  default     = "S1"

  validation {
    condition     = contains(["S1", "S2", "S3", "P0v3", "P1v3", "P2v3", "P3v3"], var.app_service_plan_sku)
    error_message = "app_service_plan_sku must support deployment slots. Allowed values: S1, S2, S3, P0v3, P1v3, P2v3, P3v3."
  }
}

variable "node_version" {
  description = "Node.js runtime version configured on the Linux App Service."
  type        = string
  default     = "20-lts"

  validation {
    condition     = contains(["18-lts", "20-lts", "22-lts"], var.node_version)
    error_message = "node_version must be one of: 18-lts, 20-lts, 22-lts."
  }
}

variable "health_check_path" {
  description = "Path used by App Service health checks and future smoke tests."
  type        = string
  default     = "/health"

  validation {
    condition     = startswith(var.health_check_path, "/") && length(var.health_check_path) <= 128
    error_message = "health_check_path must start with / and be no longer than 128 characters."
  }
}

variable "health_check_eviction_time_in_min" {
  description = "Number of minutes an unhealthy App Service instance remains in rotation before eviction."
  type        = number
  default     = 5

  validation {
    condition     = var.health_check_eviction_time_in_min >= 2 && var.health_check_eviction_time_in_min <= 10
    error_message = "health_check_eviction_time_in_min must be between 2 and 10 minutes."
  }
}

variable "log_retention_in_days" {
  description = "Retention period for Log Analytics workspace data."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_in_days >= 30 && var.log_retention_in_days <= 730
    error_message = "log_retention_in_days must be between 30 and 730."
  }
}

variable "key_vault_soft_delete_retention_days" {
  description = "Number of days deleted Key Vault objects are retained."
  type        = number
  default     = 90

  validation {
    condition     = var.key_vault_soft_delete_retention_days >= 7 && var.key_vault_soft_delete_retention_days <= 90
    error_message = "key_vault_soft_delete_retention_days must be between 7 and 90."
  }
}

variable "key_vault_public_network_access_enabled" {
  description = "Whether Key Vault public network access is enabled. Kept configurable because this reference implementation does not include private networking yet."
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "Non-secret application settings applied to both production and staging slots. Do not place secrets here."
  type        = map(string)
  default     = {}
  sensitive   = false
}

variable "tags" {
  description = "Additional tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
