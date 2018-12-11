Task Default -Depends Clean, BuildAssembly, BuildPSD, BuildDocs

FormatTaskName "-------- {0} --------"

Task BuildDocs {
  Write-Host "Generating documentation" -ForegroundColor Green
  Out-Null = New-ExternalHelp .\docs -OutputPath .\output\en-US\ -Force
}

Task BuildAssembly {
  if (-not [bool](Get-Item .\output -ErrorAction SilentlyContinue)) {
    New-Item -ItemType Directory -Path "$PSScriptRoot\output\"
  }
  &dotnet publish -c Release -o "$PSScriptRoot\output\lib\" --self-contained -f netstandard2.0 "$PSScriptRoot\src\Assembly\Assembly.csproj"
  Get-ChildItem "$PSScriptRoot\output\lib\" -Filter 'System.Management.Automation*' | Remove-Item
}

Task BuildPSD -Depends Clean, BuildAssembly {
  $itemstocopy = @(
    'PowerKube.psd1'
    'PowerKube.psm1'
    'Formats'
  )
  Write-Host "Copying PowerShell module files" -ForegroundColor Green
  foreach ($i in $itemstocopy) {
    Copy-Item -Recurse "$PSScriptRoot\src\$i" "$PSScriptRoot\output\$i"
  }
}

Task Clean {
  Write-Host "Cleaning build output directory" -ForegroundColor Green
  if ([bool](Get-Item .\output -ErrorAction SilentlyContinue)) {
    Remove-Item '.\output\*' -Recurse
  }
  else {
    Write-Host "Build output directory not found. Skipping" -ForegroundColor Yellow
  }
}