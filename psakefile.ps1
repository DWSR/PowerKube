Task Default -Depends Build 

FormatTaskName "-------- {0} --------"

Task Build -Depends Clean, InstallPSDependsForCI, InstallPSDepends, BuildAssembly, BuildPSD, BuildDocs {
}

Task BuildDocs {
  Write-Host "Generating documentation" -ForegroundColor Green
  Remove-Item ./output/en-US/ -Recurse -Force -ErrorAction SilentlyContinue
  Out-Null = New-ExternalHelp ./docs -OutputPath ./output/en-US/
  Write-Host "Finished generating documentation" -ForegroundColor Green
}

Task BuildAssembly {
  if (-not [bool](Get-Item ./output -ErrorAction SilentlyContinue)) {
    New-Item -ItemType Directory -Path "$PSScriptRoot/output/"
  }
  &dotnet publish -c Release -o "$PSScriptRoot/output/lib/" --self-contained -f netstandard2.0 "$PSScriptRoot/src/Assembly/Assembly.csproj"
  Get-ChildItem "$PSScriptRoot/output/lib/" -Filter 'System.Management.Automation*' | Remove-Item
}

Task BuildPSD -Depends BuildAssembly {
  $itemstocopy = @(
    'PowerKube.psd1'
    'PowerKube.psm1'
    'Formats'
  )
  Write-Host "Copying PowerShell module files" -ForegroundColor Green
  foreach ($i in $itemstocopy) {
    Copy-Item -Recurse "$PSScriptRoot/src/$i" "$PSScriptRoot/output/$i"
  }
}

Task Clean {
  Write-Host "Cleaning build output directory" -ForegroundColor Green
  if ([bool](Get-Item ./output -ErrorAction SilentlyContinue)) {
    Remove-Item './output/*' -Recurse
  }
  else {
    Write-Host "Build output directory not found. Skipping" -ForegroundColor Yellow
  }
}

Task Test {
  Import-Module './src/Tests/PowerKube_Tests.psd1'
  Import-Module './output/PowerKube.psd1'
  Invoke-Pester './src/Tests'
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