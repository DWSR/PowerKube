Describe "Get-K8sCurrentContext" {
  It "Gets the current context" {
    $ctx = Get-K8sCurrentContext
    $ctx | Should -BeLike 'do-nyc1-*'
    $ctx | Should -BeOfType String
  }
  It "Gets the current context with namespace" {
    $ctx = Get-K8sCurrentContext -IncludeNamespace
    $ctx | Should -BeLike 'do-nyc1-*=>default'
    $ctx | Should -BeOfType String
  }
  It "Gets the current context with a different separator" {
    $ctx = Get-K8sCurrentcontext -IncludeNamespace -NamespaceSeparator ':'
    $ctx | Should -BeLike 'do-nyc1-*:default'
    $ctx | Should -BeOfType String
  }
}