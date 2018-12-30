@{
  RootModule            = 'PowerKube.psm1'
  ModuleVersion         = '0.2.5'
  CompatiblePSEditions  = @(
    'Core'
  )
  GUID                  = '2c9e5168-bb86-4e38-b4a7-399950b23baa'
  Author                = 'Brandon McNama'
  CompanyName           = ''
  Copyright             = '(c) 2018 Brandon McNama. Available under MIT License.'
  Description           = 'A PowerShell-native replacement for the kubectl binary'
  PowerShellVersion     = '6.1'
  # ProcessorArchitecture = 'Amd64'
  RequiredModules       = @(
    @{ ModuleName = 'powershellhumanizer'; ModuleVersion = '3.1'; GUID = '6dc9be51-eb93-4355-8648-0c725c0ac988' }
  )
  # RequiredAssemblies = @()
  # ScriptsToProcess = @()
  # TypesToProcess = @()
  FormatsToProcess     = @(
    'Formats\Context.format.ps1xml'
    'Formats\Deployment.format.ps1xml'
    'Formats\Pod.format.ps1xml'
  )
  NestedModules         = @(
    ".\lib\PowerKube.dll"
  )
  FunctionsToExport     = @()
  CmdletsToExport       = @(
    "Get-K8sApiVersion"
    "Switch-K8sContext"
    "Get-K8sPod"
    "Get-K8sDeployment"
    "Resolve-K8sResourceVersion"
    "Get-K8sContext"
    "Get-K8sCurrentContext"
  )
  VariablesToExport     = @()
  AliasesToExport       = @()
  # ModuleList = @()
  # FileList = @()
  PrivateData           = @{

    PSData = @{
      Tags         = @(
        'kubernetes'
        'k8s'
        'kubectl'
        'PSEdition_Core'
        'Windows'
        'Linux'
        'macOS'
      )
      LicenseUri   = 'https://gitlab.com/dwsr/powerkube/blob/master/LICENSE'
      ProjectUri   = 'https://gitlab.com/dwsr/powerkube'

      ReleaseNotes = '
      0.2.5: Add Get-K8sContext command
             Add Get-K8sCurrentContext command
             Fix external help file not being generated

      0.2.4: Fix publish scripts (again) to work around PSDeploy issue.
             Add PowerShellHumanizer workaround instructions in README

      0.2.3: Fix publish scripts

      0.2.2: Added Get-K8sDeployment cmdlet
             Added Get-K8sApiVersion cmdlet

      0.2.1: Fix module manifest

      0.2.0: Added Get-K8sPod cmdlet

      0.1.0-beta: Initial release.
      '

    } # End of PSData hashtable

  } # End of PrivateData hashtable
}

