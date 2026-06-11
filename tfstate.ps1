# --- CONFIGURATION VARIABLES ---
$SubscriptionId    = "c6e7f0c7-4e26-460f-a38b-352ba770f183"
$ResourceGroupName = "rg-tfstate-mgmt-001"
$Location          = "eastus2"
$StorageAccountName= "coptfstatefile05" # Must be globally unique, 3-24 lowercase letters/numbers
$SkuName           = "Standard_LRS"     # Options: Standard_LRS, Standard_GRS, Premium_LRS, etc.

# --- 1. AUTHENTICATION & CONTEXT ---
Write-Host "Checking Azure connection..." -ForegroundColor Cyan
if (-not (Get-AzContext)) {
    Connect-AzAccount
}

Write-Host "Setting subscription context to: $SubscriptionId" -ForegroundColor Cyan
Set-AzContext -SubscriptionId $SubscriptionId | Out-Null

# --- 2. CREATE RESOURCE GROUP (IF NEEDED) ---
Write-Host "Verifying Resource Group '$ResourceGroupName'..." -ForegroundColor Cyan
$rg = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue

if ($null -eq $rg) {
    Write-Host "Resource Group not found. Creating it in $Location..." -ForegroundColor Yellow
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location | Out-Null
    Write-Host "Resource Group created successfully." -ForegroundColor Green
} else {
    Write-Host "Resource Group already exists." -ForegroundColor Green
}

# --- 3. CREATE STORAGE ACCOUNT ---
Write-Host "Checking if Storage Account name '$StorageAccountName' is available..." -ForegroundColor Cyan
$nameCheck = Get-AzStorageAccountNameAvailability -Name $StorageAccountName

if (-not $nameCheck.NameAvailable) {
    Write-Error "Storage Account name '$StorageAccountName' is already taken or invalid. Reason: $($nameCheck.Message)"
    exit
}

Write-Host "Creating Storage Account '$StorageAccountName'..." -ForegroundColor Yellow
$storageAccount = New-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName `
    -Location $Location `
    -SkuName $SkuName `
    -Kind "StorageV2" `
    -EnableHttpsTrafficOnly $true `
    -MinimumTlsVersion "TLS1_2"

Write-Host "Storage Account '$StorageAccountName' created successfully!" -ForegroundColor Green

# --- 4. OPTIONAL: CREATE BLOB CONTAINER (For Terraform State) ---
# If you need a container inside this account, uncomment the lines below:
# Write-Host "Creating default 'tfstate' blob container..." -ForegroundColor Cyan
# New-AzStorageContainer -Context $storageAccount.Context -Name "tfstate" -Permission Off