# Architecture

This project demonstrates an Azure App Service blue-green deployment using
Terraform and GitHub Actions.

## Target Components

- Azure Resource Group
- Azure App Service Plan
- Azure Linux Web App
- Azure App Service staging slot
- Azure Key Vault
- System-assigned Managed Identity
- Log Analytics Workspace
- Application Insights
- Azure Storage remote backend for Terraform state

## Current Status

Terraform resource implementation, sample application code, and split
infrastructure/application GitHub Actions workflows are implemented for the
development reference environment.
