🌐 Terraform AKS Deployment Overview
This Terraform configuration provisions a secure, modular Azure Kubernetes Service (AKS) environment using a service principal, Key Vault, and role-based access control. Below is a breakdown of what gets created during terraform plan and apply.

📦 Resources Created
🔹 Resource Group
azurerm_resource_group.rg1

Creates the Azure resource group (nb-aks-rg)

Used to contain all other resources

🔹 Service Principal Module (module.ServicePrincipal)
Creates an Azure AD identity for Terraform to authenticate resource provisioning.

azuread_application.main: Registers an Azure AD application

azuread_service_principal.main: Creates the service principal

azuread_service_principal_password.main: Generates a secure password

Outputs: client_id, client_secret, tenant_id, object_id

🔹 Role Assignment
azurerm_role_assignment.rolespn

Grants Contributor access to the service principal

Scope: Subscription level

🔹 Key Vault Module (module.keyvault)
Creates a secure vault for storing secrets.

azurerm_key_vault.kv: Deploys the Key Vault

Access: Grants permissions to the service principal

🔹 Key Vault Secret
azurerm_key_vault_secret.example

Stores the service principal’s client_secret securely

Enables downstream modules to retrieve credentials without hardcoding

🔹 AKS Module (module.aks)
Provisions the Kubernetes cluster.

azurerm_kubernetes_cluster.aks-cluster

Creates the AKS cluster

Authenticates using the service principal

Outputs kubeconfig for local access

🔹 Local Kubeconfig File
local_file.kubeconfig

Writes the AKS kubeconfig to ./kubeconfig

Enables kubectl access to the cluster

# AKS Deployment Architecture Diagram
This diagram illustrates the full Terraform resource flow across modules:

<architecture diagram>

Resource Group anchors all resources.

ServicePrincipal Module creates the Azure AD identity and outputs credentials.

Role Assignment grants Contributor access to the SP.

KeyVault Module stores the SP secret securely.

AKS Module provisions the Kubernetes cluster using the SP.

Local File writes the kubeconfig for kubectl access.

Each arrow shows how data flows between modules and resources.