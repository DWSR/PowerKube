#!/usr/bin/env pwsh
if (-not [bool](Get-Module -ListAvailable PSDepend)) {
  Write-Host 'Installing PSDepend module to CurrentUser scope via PowerShellGet'
  Install-Module -Name PSDepend -Scope CurrentUser -Force
}
Import-Module PSDepend
Write-Host 'Installing PowerKube dependencies' -ForegroundColor Green
Invoke-PSDepend -Path $PSScriptRoot -Force
