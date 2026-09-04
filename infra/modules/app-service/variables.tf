variable "name_prefix" {
  description = "Shared naming prefix for App Service resources."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,48}$", var.name_prefix))
    error_message = "name_prefix must be 3-48 characters and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  description = "Azure region for App Service resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where App Service resources are deployed."
  type        = string
}

variable "sku_name" {
  description = "App Service Plan SKU. Must support deployment slots."
  type        = string

  validation {
    condition     = contains(["S1", "S2", "S3", "P0v3", "P1v3", "P2v3", "P3v3"], var.sku_name)
    error_message = "sku_name must support deployment slots. Allowed values: S1, S2, S3, P0v3, P1v3, P2v3, P3v3."
  }
}

variable "node_version" {
  description = "Node.js runtime version for the Linux Web App and staging slot."
  type        = string

  validation {
    condition     = contains(["18-lts", "20-lts", "22-lts"], var.node_version)
    error_message = "node_version must be one of: 18-lts, 20-lts, 22-lts."
  }
}

variable "health_check_path" {
  description = "Health check path configured on production and staging slots."
  type        = string

  validation {
    condition     = startswith(var.health_check_path, "/") && length(var.health_check_path) <= 128
    error_message = "health_check_path must start with / and be no longer than 128 characters."
  }
}

variable "health_check_eviction_time_in_min" {
  description = "Number of minutes an instance can remain unhealthy before App Service removes it from load balancing."
  type        = number

  validation {
    condition     = var.health_check_eviction_time_in_min >= 2 && var.health_check_eviction_time_in_min <= 10
    error_message = "health_check_eviction_time_in_min must be between 2 and 10 minutes."
  }
}

variable "application_insights_connection" {
  description = "Application Insights connection string injected as an app setting."
  type        = string
  sensitive   = true
}

variable "app_settings" {
  description = "Additional non-secret app settings applied to production and staging slots."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags applied to App Service resources."
  type        = map(string)
  default     = {}
}
