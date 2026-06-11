[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$tools = @("az", "terraform", "git")
foreach ($tool in $tools) {
    $command = Get-Command $tool -ErrorAction SilentlyContinue
    if (-not $command) {
        throw "$tool is not installed or not on PATH."
    }
    Write-Host "$tool found at $($command.Source)"
}

Write-Host "Checking Azure CLI login..."
az account show --query "{name:name, subscription:id, tenant:tenantId}" --output table

Write-Host "Prerequisite validation completed."
