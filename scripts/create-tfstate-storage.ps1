[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [string]$ResourceGroupName = "rg-tfstate-mgmt-001",
    [string]$Location = "eastus2",
    [string]$StorageAccountName,
    [string]$ContainerName = "tfstate"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not $StorageAccountName) {
    $suffix = (Get-Random -Minimum 100000 -Maximum 999999)
    $StorageAccountName = "sttfstate$suffix"
}

if ($StorageAccountName.Length -gt 24 -or $StorageAccountName -notmatch "^[a-z0-9]+$") {
    throw "StorageAccountName must be 3-24 lowercase letters and numbers."
}

Write-Host "Setting Azure subscription context..."
az account set --subscription $SubscriptionId

Write-Host "Creating Terraform state resource group..."
az group create `
    --name $ResourceGroupName `
    --location $Location `
    --tags Purpose=TerraformState ManagedBy=Script DataClass=Confidential

Write-Host "Creating hardened storage account for remote state..."
az storage account create `
    --name $StorageAccountName `
    --resource-group $ResourceGroupName `
    --location $Location `
    --sku Standard_ZRS `
    --kind StorageV2 `
    --min-tls-version TLS1_2 `
    --allow-blob-public-access false `
    --https-only true `
    --default-action Allow

Write-Host "Enabling blob versioning and soft delete..."
az storage account blob-service-properties update `
    --account-name $StorageAccountName `
    --resource-group $ResourceGroupName `
    --enable-versioning true `
    --enable-delete-retention true `
    --delete-retention-days 30 `
    --enable-container-delete-retention true `
    --container-delete-retention-days 30

Write-Host "Creating state container..."
az storage container create `
    --name $ContainerName `
    --account-name $StorageAccountName `
    --auth-mode login

Write-Host ""
Write-Host "Backend configuration values:"
Write-Host "resource_group_name  = `"$ResourceGroupName`""
Write-Host "storage_account_name = `"$StorageAccountName`""
Write-Host "container_name       = `"$ContainerName`""
Write-Host ""
Write-Host "Private endpoint guidance:"
Write-Host "For production, set the storage firewall default action to Deny, add a private endpoint for blob, and configure privatelink.blob.core.windows.net DNS resolution."
