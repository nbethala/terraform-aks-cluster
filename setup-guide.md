📦 Modular AKS Cluster Provisioning with Terraform, Azure Key Vault, and Service Principal

🎯 Project Goal
Provision a secure, production-ready Azure Kubernetes Service (AKS) cluster using modular Terraform architecture. Integrate Azure Key Vault for secret management and use a scoped Service Principal for authentication and RBAC.

## 🔧 Setup Guide

### Prerequisites
- Terraform CLI installed
- Azure CLI authenticated
- Active Azure subscription

### Steps
1. Clone the repository
2. Update `terraform.tfvars` with your values
3. Run `terraform init`
4. Run `terraform apply`
5. Access your AKS cluster using the exported `kubeconfig`

For troubleshooting, see [troubleshooting.md](./troubleshooting.md)


🧱 Project Structure
plaintext
tf-aks/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars
├── troubleshooting.md
├── README.md
├── modules/
│   ├── ServicePrincipal/
│   ├── keyvault/
│   └── aks/


🗂️ Modules Overview
Module	Purpose
ServicePrincipal	Creates Azure AD App, SP, password, and outputs credentials
keyvault	Provisions Key Vault and stores SP secret securely
aks	Deploys AKS cluster using SP credentials and outputs kubeconfig
🔐 Identity and Access Flow
Terraform creates a Service Principal

SP is granted Contributor role on the subscription

SP is granted Key Vault Secrets Officer on the Key Vault

SP credentials are stored in Key Vault

AKS cluster is provisioned using SP credentials

Kubeconfig is exported locally for kubectl access

🛠️ Implementation Steps
1. Initialize Project
bash
terraform init
2. Create Service Principal
hcl
module "ServicePrincipal" {
  source = "./modules/ServicePrincipal"
  service_principal_name = var.service_principal_name
  providers = { azuread = azuread.aad }
}
3. Assign Roles
hcl
resource "azurerm_role_assignment" "rolespn" {
  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.ServicePrincipal.service_principal_object_id
}
4. Provision Key Vault
hcl
module "keyvault" {
  source = "./modules/keyvault"
  ...
  providers = { azurerm = azurerm.sp }
}
5. Store SP Secret
hcl
resource "azurerm_key_vault_secret" "example" {
  provider     = azurerm.sp
  name         = module.ServicePrincipal.client_id
  value        = module.ServicePrincipal.client_secret
  key_vault_id = module.keyvault.keyvault_id
}
6. Deploy AKS Cluster
hcl
module "aks" {
  source = "./modules/aks"
  ...
  providers = { azurerm = azurerm.sp }
}
7. Export Kubeconfig
hcl
resource "local_file" "kubeconfig" {
  filename = "./kubeconfig"
  content  = module.aks.config
}
🧪 Validation
Run terraform plan to preview changes

Run terraform apply to deploy

Test access:

bash
kubectl get nodes --kubeconfig=./kubeconfig
📘 Documentation
README.md: Overview, architecture diagram, usage instructions

troubleshooting.md: Common errors (403, RBAC, VM size, zone support)

provider.tf: Scoped provider using SP credentials