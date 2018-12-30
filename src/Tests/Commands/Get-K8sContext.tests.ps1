Describe "Get-K8sContext" {
  BeforeAll {
    Write-MockKubeConfig -Path TestDrive:/kubeconfig -ContextNames foo,bar
    $PSDefaultParameterValues.Add('Get-K8sContext:KubeConfig', (Join-Path $TestDrive "kubeconfig"))
  }
  AfterAll {
    $PSDefaultParameterValues.Remove('Get-K8sContext:KubeConfig')
  }
  It "Gets all contexts" {
    $ctxs = Get-K8sContext
    $ctxs.Count | Should -Be 2
  }
  It "Gets a specific context" {
    $ctxs = Get-K8sContext 'foo'
    $ctxs.Count | Should -Be 1
  }
}