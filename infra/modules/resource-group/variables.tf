variable "name" {
  description = "Name of the Azure Resource Group."
  type        = string

  validation {
    condition     = can(regex("^rg-[a-zA-Z0-9._()-]{1,86}$", var.name))
    error_message = "name must start with rg- and be valid for an Azure Resource Group."
  }
}

variable "location" {
  description = "Azure region for the Resource Group."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location cannot be empty."
  }
}

variable "tags" {
  description = "Tags applied to the Resource Group."
  type        = map(string)
  default     = {}
}
