$Here = Split-Path -Parent $PSScriptRoot
$Scripts = Get-ChildItem “$here\” -Filter ‘*.ps1’ -Recurse | Where-Object {$_.name -NotMatch ‘Tests.ps1’}
$Modules = Get-ChildItem “$here\” -Filter ‘*.psm1’ -Recurse
$Rules = Get-ScriptAnalyzerRule
if ($Modules.count -gt 0) {
    Describe ‘Testing all Modules in this Repo to be be correctly formatted’ {
        foreach ($module in $modules) {
            Context “Testing Module  – $($module.BaseName) for Standard Processing” {
                foreach ($rule in $rules) {
                    It “passes the PSScriptAnalyzer Rule $rule“ {
                        (Invoke-ScriptAnalyzer -Path $module.FullName -IncludeRule $rule.RuleName ).Count | Should Be 0
                    }
                }
            }
        }
    }
}

if ($Scripts.count -gt 0) {
    Describe ‘Testing all Scripts in this Repo to be be correctly formatted’ {
        foreach ($Script in $scripts) {
            Context “Testing Module  – $($script.BaseName) for Standard Processing” {
                foreach ($rule in $rules) {
                    It “passes the PSScriptAnalyzer Rule $rule“ {
                        (Invoke-ScriptAnalyzer -Path $script.FullName -IncludeRule $rule.RuleName ).Count | Should Be 0
                    }
                }
            }
        }
    }
} 