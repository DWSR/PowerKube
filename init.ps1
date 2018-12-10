#!/usr/bin/env pwsh
if (-not [bool](Get-Module -ListAvailable PSDepend)) {
  Write-Host 'Installing PSDepend module to CurrentUser scope via PowerShellGet'
  Install-Module -ModuleName PSDepend -Scope CurrentUser
}
Import-Module PSDepend
Write-Host 'Installing PowerKube dependencies' -ForegroundColor Green
Invoke-PSDepend -Path $PSScriptRoot -Force