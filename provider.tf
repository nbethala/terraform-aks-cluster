# Configure the Azure provider, you can have many
# if you use azurerm provider, it's source is hashicorp/azurerm
# short for registry.terraform.io/hashicorp/azurerm


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.12.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.9.0"
}

# ✅ Default azurerm provider (required even if unused directly)
provider "azurerm" {
    features {}
    subscription_id = var.SUB_ID
}

# ✅ Scoped azurerm provider using service principal credentials
provider "azurerm" {
  alias           = "sp"
  subscription_id = var.SUB_ID
  client_id       = module.ServicePrincipal.client_id
  client_secret   = module.ServicePrincipal.client_secret
  tenant_id       = module.ServicePrincipal.service_principal_tenant_id

  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

# ✅ AzureAD provider for service principal creation
provider "azuread" {
  alias = "aad"
}

