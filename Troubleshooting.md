❌ 403 Forbidden: AuthorizationFailed
Error:

text
The client '<object_id>' does not have authorization to perform action 'Microsoft.Resources/subscriptions/providers/read'
Cause: The Service Principal lacks Contributor access to the subscription.

Fix: Manually assign the role in Azure Portal:

Go to Subscriptions → [Your Subscription] → Access Control (IAM)

Click + Add → Add role assignment

Role: Contributor

Assign to: nb-aks-sp (your Service Principal)

⚠️ After assigning, run az login to refresh credentials.

🔁 Fresh az login Required
Symptoms:

Terraform fails to authenticate

Role assignments don’t take effect

Provider cache errors

Fix: Run:

bash
az account clear
az login
This refreshes your session and clears stale tokens.

Provider Alias Not Recognized in Modules
Warning:

text
Reference to undefined provider: azurerm.sp
Cause: Child module doesn’t declare the expected provider.

Fix: Inside the module (e.g., modules/keyvault/terraform.tf), add:

hcl
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}


❌ features = {} Syntax Error
Error:

text
An argument named "features" is not expected here
Cause: Incorrect map-style syntax for features.

Fix: Use block-style syntax:

hcl
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}


## ❌ Key Vault Secret Access Denied

**Error:**
```text
Caller is not authorized to perform action 'Microsoft.KeyVault/vaults/secrets/getSecret/action'
Fix: Assign Key Vault Secrets Officer role to the Service Principal in Azure Portal → Key Vault → Access Control (IAM).


❌ AKS Availability Zone Not Supported
Error:

text
The zone(s) '2' for resource 'defaultpool' is not supported in location 'eastus'
Fix: Remove or adjust availability_zones in your AKS module. East US may not support zones for AKS in your configuration.


❌ AKS VM Size Not Allowed
Error:

text
The VM size of Standard_DS2_v2 is not allowed in your subscription in location 'eastus'
Fix: Use one of the allowed VM sizes listed in the error message (e.g., Standard_A2_v2). Update your AKS module accordingly.






