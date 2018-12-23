

@{
  RootModule            = 'PowerKube.psm1'
  ModuleVersion         = '0.1.0'
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
  FormatsToProcess      = '*'
  NestedModules         = @(
    ".\lib\PowerKube.dll"
  )
  FunctionsToExport     = @()
  CmdletsToExport       = @(
    # "Get-K8sApiVersion"
    "Switch-K8sContext"
    "Get-K8sPod"
    # "Get-K8sDeployment"
    "Resolve-K8sResourceVersion"
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
      0.1.0-beta: Initial release.
      '

    } # End of PSData hashtable

  } # End of PrivateData hashtable
}

