# Modular AKS Infrastructure with Terraform and Azure Key Vault


## 🚀 Overview
This project provisions a secure, production-grade Azure Kubernetes Service (AKS) cluster using modular Terraform architecture. It integrates Azure Key Vault for secret management and uses a scoped Service Principal for RBAC-compliant authentication. The design emphasizes reproducibility, security, and operational clarity — ideal for real-world DevOps and platform engineering use cases.

## 💼 Business Problem
A mid-sized SaaS company needed to deploy containerized microservices across dev, staging, and production environments. However, they lacked a reproducible infrastructure setup. Manual provisioning led to:

 - Inconsistent environments across teams

 - Risky secret handling practices

 - Delayed onboarding and release cycles

 - No clear RBAC separation between environments

## ✅ Solution
This project solves the problem by delivering:

 - Modular Terraform code for reusable infrastructure components

 - Scoped Service Principal with RBAC roles for secure provisioning

 - Azure Key Vault integration for secret storage and access control

 - AKS cluster provisioning with kubeconfig export for local access

 - Visual documentation and troubleshooting guides for fast onboarding

## 🧱 Architecture Highlights
  Modules: ServicePrincipal, KeyVault, AKS

 - Scoped Provider: Uses azurerm.sp alias to isolate SP credentials

 - RBAC: SP granted Contributor and Key Vault Secrets Officer roles

 - Secrets: SP credentials stored securely in Key Vault

 - Outputs: Local kubeconfig file for kubectl access

## 🔐 Security & Compliance
  - Secrets never hardcoded — stored in Key Vault

  -  SP credentials scoped to subscription and vault only

  -  Terraform uses least-privilege identity for all operations

  - RBAC roles assigned via Terraform for auditability

## 🧪 Validation
 - terraform plan and apply tested across multiple environments

 - kubectl get nodes confirms AKS cluster provisioning

 - Manual and automated role assignment tested for SP and Key Vault

 - Troubleshooting guide documents real-world RBAC and quota issues

## 📈 Business Impact
 - Reduced environment setup time from hours to minutes

 - Eliminated manual secret handling risks

 - Enabled CI/CD integration and GitOps readiness

 - Improved onboarding with clear documentation and modular code

 - Future-proofed for Helm, observability, and workload scaling

## 📎 Repository Highlights
 - main.tf: Root orchestration with scoped provider wiring

 - modules/: Reusable Terraform modules for SP, Key Vault, and AKS

 - troubleshooting.md: Real-world error handling and RBAC propagation tips

 - README.md: Architecture diagram, usage instructions, and business framing

## 🧭 Next Steps
 - Add Helm module for workload deployment

 - Integrate Prometheus/Grafana for observability

 - Add CI/CD pipeline for automated provisioning

 - Expand to multi-region or multi-cluster setups


## 📘 Setup Instructions

For a complete guide to setting up this repository, including prerequisites, environment configuration, and deployment steps, see [setup-guide.md](./setup-guide.md).
