variable "name_prefix" {
  description = "Shared naming prefix for monitoring resources."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,60}$", var.name_prefix))
    error_message = "name_prefix must be 3-60 characters and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  description = "Azure region for monitoring resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where monitoring resources are deployed."
  type        = string
}

variable "retention_in_days" {
  description = "Log Analytics retention period in days."
  type        = number

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "retention_in_days must be between 30 and 730."
  }
}

variable "tags" {
  description = "Tags applied to monitoring resources."
  type        = map(string)
  default     = {}
}
