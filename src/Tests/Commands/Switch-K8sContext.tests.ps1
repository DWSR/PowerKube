Describe "Switch-K8sContext" {
  BeforeAll {
    Write-MockKubeConfig -Path TestDrive:/kubeconfig -ContextNames foo,bar
    $PSDefaultParameterValues.Add('Switch-K8sContext:KubeConfig', (Join-Path $TestDrive "kubeconfig"))
  }
  AfterAll {
    $PSDefaultParameterValues.Remove('Switch-K8sContext:KubeConfig')
  }
  It "Rejects unknown context" {
    { Switch-K8sContext -Context "DoesntExist" } |
      Should -Throw "Must provide a context that is already present in the specified config file."
  }
  It "Rejects unknown config file" {
    { Switch-K8sContext -Context "foo" -KubeConfig "nonexistent_file" } |
      Should -Throw "kubeconfig file not found at"
  }
  It "Changes contexts" {
    { Switch-K8sContext -Context "foo" } | Should -Not -Throw
    $before = Get-Content -Raw TestDrive:/kubeconfig
    $before -match 'current-context.+foo' | Should -Be $true
    { Switch-K8sContext -Context "bar" } | Should -Not -Throw
    $after = Get-Content -Raw TestDrive:/kubeconfig
    $after -match 'current-context.+bar' | Should -Be $true
  }
}