# Step-by-Step Deployment Runbook

This runbook explains how to install the tools, upload this project to GitHub, configure Terraform remote state, and deploy the landing-zone lab to Azure.

## 1. Where to Install Terraform

Install the Terraform CLI on your local VM or workstation. Visual Studio Code extensions are useful for editing Terraform, but they do not replace the Terraform CLI.

You will use Terraform in three places:

- Local VM or workstation: for learning, testing, `terraform fmt`, `terraform validate`, `terraform plan`, and controlled lab applies.
- GitHub Actions hosted runner: installed automatically by the workflow using `hashicorp/setup-terraform`.
- Azure DevOps hosted agent: installed automatically by the pipeline using `TerraformInstaller@1`.

Recommended local tools:

- Terraform CLI
- Azure CLI
- Git
- Visual Studio Code
- HashiCorp Terraform VS Code extension
- PowerShell 7

## 2. Install Tools on Your Local VM

Open PowerShell as Administrator and install tools with WinGet:

```powershell
winget install --id Hashicorp.Terraform -e
winget install --id Microsoft.AzureCLI -e
winget install --id Git.Git -e
winget install --id Microsoft.VisualStudioCode -e
winget install --id GitHub.cli -e
```

Close and reopen PowerShell, then verify:

```powershell
terraform version
az version
git --version
gh --version
code --version
```

Install the VS Code Terraform extension:

```powershell
code --install-extension HashiCorp.terraform
```

## 3. Open the Project in VS Code

```powershell
cd "C:\Users\Maury\Documents\Codex\2026-06-06\you-are-an-expert-azure-devops\azure-devops-terraform-enterprise-lab"
code .
```

Review the folder structure:

```text
terraform/backend
terraform/environments/management-hub
terraform/environments/network
terraform/environments/dev
terraform/environments/prod
terraform/modules
pipelines/azure-devops
pipelines/github-actions
scripts
docs
governance
```

## 4. Sign in to Azure

```powershell
az login
az account list --output table
```

Set your Management Hub subscription first because remote state storage is created there:

```powershell
az account set --subscription "<management-hub-subscription-id>"
```

## 5. Replace Placeholder Values

Edit these files:

```text
terraform/environments/management-hub/terraform.tfvars
terraform/environments/network/terraform.tfvars
terraform/environments/dev/terraform.tfvars
terraform/environments/prod/terraform.tfvars
```

Replace:

```text
REPLACE-WITH-TENANT-ID
REPLACE-WITH-MANAGEMENT-SUBSCRIPTION-ID
REPLACE-WITH-NETWORK-SUBSCRIPTION-ID
REPLACE-WITH-DEV-SUBSCRIPTION-ID
REPLACE-WITH-PROD-SUBSCRIPTION-ID
```

Use Azure CLI to find these values:

```powershell
az account show --query tenantId -o tsv
az account list --query "[].{name:name, subscriptionId:id}" -o table
```

## 6. Create Terraform Remote State Storage

From the repository root:

```powershell
.\scripts\create-tfstate-storage.ps1 `
  -SubscriptionId "<management-hub-subscription-id>" `
  -ResourceGroupName "rg-tfstate-mgmt-001" `
  -Location "eastus2" `
  -StorageAccountName "<globally-unique-storage-account-name>"
```

The storage account name must be globally unique, lowercase, and 3-24 characters. Example:

```text
sttfstateentlab12345
```

Update these files with the storage account name:

```text
terraform/backend/management-hub.backend.tfvars
terraform/backend/network.backend.tfvars
terraform/backend/dev.backend.tfvars
terraform/backend/prod.backend.tfvars
```

Replace:

```text
storage_account_name = "REPLACE_WITH_TFSTATE_STORAGE"
```

## 7. Configure Local Terraform Authentication

For the lab, use your service principal values as environment variables:

```powershell
$env:ARM_CLIENT_ID = "aa92898b-1a07-4e45-9236-67d3711e9c99"
$env:ARM_CLIENT_SECRET = "<service-principal-client-secret>"
$env:ARM_TENANT_ID = "7343d188-f98c-4793-97f3-e6ccd3787248"
```

Terraform uses subscription IDs from each environment's `terraform.tfvars`.

For production, use workload identity federation/OIDC instead of long-lived client secrets.

## 8. Validate Terraform Locally

Run format from the repo root:

```powershell
terraform fmt -recursive
```

Validate each root:

```powershell
cd terraform/environments/management-hub
terraform init -backend-config="../../backend/management-hub.backend.tfvars"
terraform validate
terraform plan
```

Repeat for:

```powershell
cd ../network
terraform init -backend-config="../../backend/network.backend.tfvars"
terraform validate
terraform plan

cd ../dev
terraform init -backend-config="../../backend/dev.backend.tfvars"
terraform validate
terraform plan

cd ../prod
terraform init -backend-config="../../backend/prod.backend.tfvars"
terraform validate
terraform plan
```

## 9. Recommended Deployment Order

Deploy in this order:

1. `management-hub`
2. `network`
3. `dev`
4. `prod`

Apply management first:

```powershell
cd terraform/environments/management-hub
terraform apply
```

Then network:

```powershell
cd ../network
terraform apply
```

Then dev:

```powershell
cd ../dev
terraform apply
```

Then prod after reviewing the plan carefully:

```powershell
cd ../prod
terraform plan
terraform apply
```

## 10. Create the GitHub Repository

Option A: GitHub website

1. Go to GitHub.
2. Create a new repository named `azure-devops-terraform-enterprise-lab`.
3. Do not initialize with README, `.gitignore`, or license because this project already has files.
4. Copy the repository URL.

Option B: GitHub CLI

```powershell
gh auth login
gh repo create azure-devops-terraform-enterprise-lab --private --source . --remote origin
```

## 11. Upload the Project to GitHub

From the repository root:

```powershell
git init
git branch -M main
git status
git add .
git commit -m "Initial enterprise Azure Terraform landing zone lab"
git remote add origin https://github.com/<your-github-user-or-org>/azure-devops-terraform-enterprise-lab.git
git push -u origin main
```

If you used `gh repo create --source . --remote origin`, skip `git remote add origin` and run:

```powershell
git push -u origin main
```

## 12. Enable GitHub Actions

GitHub only detects workflows under `.github/workflows`. Copy the workflow files:

```powershell
New-Item -ItemType Directory -Force -Path .github/workflows
Copy-Item pipelines/github-actions/*.yml .github/workflows/
git add .github/workflows
git commit -m "Enable GitHub Actions Terraform workflows"
git push
```

Add GitHub secrets:

```text
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_TENANT_ID
ARM_SUBSCRIPTION_ID
```

For production governance, create GitHub Environments:

- `dev`
- `prod`

Add required reviewers to `prod`.

## 13. Configure Azure DevOps

In Azure DevOps:

1. Create a project.
2. Create service connection `sc-azure-nonprod-terraform`.
3. Create service connection `sc-azure-prod-terraform`.
4. Create variable group `vg-terraform-common`.
5. Add secure variables or link Azure Key Vault.
6. Create Environments: `dev`, `prod`, `management-hub`, and `network`.
7. Add approval checks to `prod`.

Create pipelines from existing YAML:

```text
pipelines/azure-devops/azure-pipelines-terraform-pr-validation.yml
pipelines/azure-devops/azure-pipelines-terraform-plan.yml
pipelines/azure-devops/azure-pipelines-terraform-apply.yml
pipelines/azure-devops/azure-pipelines-multistage.yml
```

## 14. Run the Azure DevOps Flow

1. Create a feature branch.
2. Open a pull request.
3. PR validation runs fmt, validate, and Checkov.
4. Run the plan pipeline manually and select environment.
5. Review the published plan artifact.
6. Run apply pipeline manually.
7. Approve production through Azure DevOps Environment approval.
8. Validate resources in Azure.

## 15. Validate Deployed Azure Resources

Use Azure Portal or CLI:

```powershell
az group list --query "[?contains(name, 'entlab')].{name:name, location:location}" -o table
az resource list --tag ManagedBy=Terraform -o table
```

Check:

- Resource groups exist in the correct subscriptions.
- Terraform state files exist in the backend storage container.
- Log Analytics, Key Vault, storage, VNet, App Service, and Application Insights were created.
- Tags are present.
- No secrets were committed.

## 16. Promotion from Dev to Prod

1. Make changes in a feature branch.
2. Validate and plan dev.
3. Apply dev.
4. Review behavior.
5. Generate prod plan.
6. Review prod plan artifact.
7. Approve prod.
8. Apply prod.
9. Save validation evidence.

## 17. Clean Up Lab Resources

Destroy in reverse order:

```powershell
cd terraform/environments/prod
terraform destroy

cd ../dev
terraform destroy

cd ../network
terraform destroy

cd ../management-hub
terraform destroy
```

Delete the Terraform state storage account only after every environment is destroyed and you no longer need the state history.
