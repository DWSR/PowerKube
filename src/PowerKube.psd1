@{

# Script module or binary module file associated with this manifest.
RootModule = 'PowerKube.psm1'

# Version number of this module.
ModuleVersion = '0.1'

# ID used to uniquely identify this module
GUID = '2c9e5168-bb86-4e38-b4a7-399950b23baa'

# Author of this module
Author = 'Brandon McNama'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2018 Brandon McNama. Available under MIT License.'

# Description of the functionality provided by this module
Description = 'A PowerShell-native replacement for the kubectl binary'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '6.1.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
ProcessorArchitecture = 'Amd64'

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
  @{ ModuleName = 'powershellhumanizer'; ModuleVersion = '3.1'; GUID = '6dc9be51-eb93-4355-8648-0c725c0ac988' }
)

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @(

)

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @(
	".\Formats\Pod.format.ps1xml"
)

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(
	".\lib\PowerKube.dll"
)

# Functions to export from this module
FunctionsToExport = 'Get-Function'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

