[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$Scope
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Creating service principal with Contributor at the requested scope."
Write-Host "Lab shortcut: Owner is acceptable for learning, but production should split plan/apply identities and minimize scope."

az ad sp create-for-rbac `
    --name $Name `
    --role Contributor `
    --scopes $Scope `
    --sdk-auth

Write-Host "Store the output as a secure pipeline secret or use OIDC federation instead of a client secret."
