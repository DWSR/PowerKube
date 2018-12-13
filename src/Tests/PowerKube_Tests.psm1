function Write-MockKubeConfig {
  [CmdletBinding()]
  Param(
    # Specifies a path to write the mock config too
    [Parameter(
      Mandatory = $true,
      Position = 0,
      ValueFromPipeline = $true,
      ValueFromPipelineByPropertyName = $true,
      HelpMessage = "Path to location."
    )]
    [Alias("PSPath")]
    [ValidateNotNullOrEmpty()]
    [string]
    $Path,

    # Specify the name of contexts to generate
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    $ContextNames = @('default')
  )
  Process {
    try {
      if (Test-Path $Path) {
        New-Item -Path (Split-Path $Path -Parent) -Name (Split-Path $Path -Leaf) -ItemType File
      }
    }
    catch [System.IO.IOException] {
      $e = [System.ArgumentException]::new($_.Message)
      throw $e
    }
    $config = @{
      apiVersion  = 'v1'
      kind        = 'Config'
      clusters    = @()
      'current-context' = $ContextNames[0]
      contexts    = @()
      preferences = @{}
      users       = @()
    }
    foreach ($ctx in $ContextNames) {
      $cluster = @{
        name = "$ctx-cluster"
        cluster = @{
          'insecure-skip-tls-verify' = $true
          server                     = 'https://localhost:6445'
        }
      }
      $config.clusters += @($cluster)
      $user = @{
        name = $ctx
        user = @{
          'client-certificate-data' = ''
          'client-key-data' = ''
        }
      }
      $config.users += @($user)
      $context = @{
        name = $ctx
        context = @{
          cluster = "$ctx-cluster"
          user = $ctx
        }
      }
      $config.contexts += @($context)
    }
    # We write out JSON here because it's YAML compatible and both PSYaml and powershell-yaml
    # have weird issues.
    Set-Content -Path $Path -Value (ConvertTo-Json $config -Depth 100)
  }
}