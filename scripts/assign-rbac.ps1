[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$AssigneeObjectId,

    [Parameter(Mandatory = $true)]
    [string]$Scope,

    [string]$Role = "Contributor"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Assigning $Role at $Scope to $AssigneeObjectId..."
az role assignment create `
    --assignee-object-id $AssigneeObjectId `
    --assignee-principal-type ServicePrincipal `
    --role $Role `
    --scope $Scope

Write-Host "Use User Access Administrator only when the pipeline must create RBAC assignments."
