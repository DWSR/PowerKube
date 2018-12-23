Task Default -Depends Build 

FormatTaskName "-------- {0} --------"

Task Build -Depends Clean, InstallPSDependsForCI, BuildAssembly, BuildPSD, BuildDocs {
}

Task BuildDocs {
  Write-Output "Generating documentation" -ForegroundColor Green
  Remove-Item ./PowerKube/en-US/ -Recurse -Force -ErrorAction SilentlyContinue
  Out-Null = New-ExternalHelp ./docs -OutputPath ./PowerKube/en-US/
  Write-Output "Finished generating documentation" -ForegroundColor Green
}

Task BuildAssembly {
  if (-not [bool](Get-Item ./PowerKube -ErrorAction SilentlyContinue)) {
    New-Item -ItemType Directory -Path "$PSScriptRoot/PowerKube/"
  }
  &dotnet publish -c Release -o "$PSScriptRoot/PowerKube/lib/" --self-contained -f netstandard2.0 "$PSScriptRoot/src/Assembly/Assembly.csproj"
  if ($LASTEXITCODE -ne 0) {
      if ($env:CI) {
        $Host.SetShouldExit(1)
      } else {
        throw [System.Exception]::new("Build failed")
      }
  }
  Get-ChildItem "$PSScriptRoot/PowerKube/lib/" -Filter 'System.Management.Automation*' | Remove-Item
}

Task BuildPSD -Depends BuildAssembly {
  $itemstocopy = @(
    'PowerKube.psd1'
    'PowerKube.psm1'
    'Formats'
  )
  Write-Host "Copying PowerShell module files" -ForegroundColor Green
  foreach ($i in $itemstocopy) {
    Copy-Item -Recurse "$PSScriptRoot/src/$i" "$PSScriptRoot/PowerKube/$i"
  }
  try {
    Test-ModuleManifest -Path "$PSScriptRoot/PowerKube/PowerKube.psd1"
  }
  catch [ArgumentException] {
    if ($env:CI) {
      exit 1
    }
    else {
      throw $_
    }
  }
}

Task Clean {
  Write-Host "Cleaning build output directory" -ForegroundColor Green
  if ([bool](Get-Item ./PowerKube -ErrorAction SilentlyContinue)) {
    Remove-Item './PowerKube/*' -Recurse
  }
  else {
    Write-Host "Build PowerKube directory not found. Skipping" -ForegroundColor Yellow
  }
}

Task Test {
  Import-Module './src/Tests/PowerKube_Tests.psd1'
  Import-Module './PowerKube/PowerKube.psd1'
  try {
    if (-not [String]::IsNullOrEmpty($env:KUBECONFIG)) {
      $prevConfig = $env:KUBECONFIG
    }
    $env:KUBECONFIG = "$PSScriptRoot/src/Tests/terraform/kubeconfig"
    $pester = Invoke-Pester './src/Tests' -Strict -PassThru
  }
  finally {
    if ([bool](Get-Variable -Name prevConfig -ErrorAction SilentlyContinue)) {
      $env:KUBECONFIG = $prevConfig
    }
    else {
      $env:KUBECONFIG = $null
    }
    if ($null -eq $pester -or $pester.FailedCount -gt 0) {
      if ($env:CI) {
        $Host.SetShouldExit(1)
      } else {
        throw [System.Exception]::new("Tests failed")
      }
    }
  }
}

Task Format {
}

Task InstallPSDepends -Precondition { -not $env:CI } {
  Invoke-PSDepend -Path $PSScriptRoot -Force
}

Task InstallPSDependsForCI -Precondition { $env:CI } {
  # This works around a bug in PSDepend when comparing versions that are coercable to doubles (such
  # as 3.1). PowerShellHumanizer is the only module that we depend on that does this, so it gets
  # special treatment 
  if ((Test-Path "$PSScriptRoot/.psdependencies/PowerShellHumanizer")) {
    Remove-Item -Recurse -Force "$PSScriptRoot/.psdependencies/PowerShellHumanizer"
  }
  Invoke-PSDepend -Path $PSScriptRoot -Force -Target "$PSScriptRoot/.psdependencies"
  # This works around a bug in PowerShellHumanizer where it imports a lower case file name, but that
  # file's name is actually title case.
  $dllPath = Resolve-Path "$PSScriptRoot/.psdependencies/PowerShellHumanizer/*/Humanizer.dll"
  Move-Item "$(Split-Path $dllPath -Parent)/Humanizer.dll" "$(Split-Path $dllPath -Parent)/humanizer.dll"
}

Task Publish {
  if ([String]::IsNullOrEmpty($env:PSGALLERY_API_KEY)) {
    Write-Error "PSGallery API Key not provided. Skipping publish."
    if ($env:CI) {
      $Host.SetShouldExit(1)
    }
  }
  else {
    Set-BuildEnvironment
    if (
        $env:BHModulePath -and
        $env:BHBranchName -eq "master" -and
        $env:BHCommitMessage -match '!deploy'
    ) {
      Set-ModuleFormats -FormatsRelativePath Formats
      Invoke-PSDeploy -Force
    } else {
      "Skipping deployment: To deploy, ensure that...`n" +
      "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
      "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage)" |
      Write-Output
    }
  }
}
