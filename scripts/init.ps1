#!/usr/bin/env pwsh
if (-not [bool](Get-Module -ListAvailable PSDepend)) {
  Write-Host 'Installing PSDepend module to CurrentUser scope via PowerShellGet'
  Install-Module -Name PSDepend -Scope CurrentUser -Force
}
if (-not [bool](Get-Module -ListAvailable psake)) {
  Write-Host 'Installing psake module to CurrentUser scope via PowerShellGet'
  Install-Module -Name psake -Scope CurrentUser -Force
}
Import-Module PSDepend
Import-Module psake