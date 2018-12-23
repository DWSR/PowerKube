Describe 'Get-K8sDeployment' {
  Context 'General Functionality' {
    It 'Gets deployments' {
      $d = Get-K8sDeployment
      $d.Count | Should -BeGreaterOrEqual 1
    }
    It 'Gets deployments in a different namespace' {
      $d = Get-K8sDeployment -Namespace 'kube-system'
      $e = Get-K8sDeployment
      $d.Count | Should -BeGreaterOrEqual 1
      $d[0].Metadata.Name | Should -Not -Be $e[0].Metadata.Name
    }
    It 'Gets deployments in all namespaces' {
      $d = Get-K8sDeployment -AllNamespaces
      $d.Count | Should -BeGreaterOrEqual 3
    }
    It 'Gets a specific deployment' {
      $deployments = Get-K8sDeployment
      $aDeployment = Get-K8sDeployment -Name $deployments[0].Metadata.Name
      $aDeployment.Metadata.Name | Should -Be $deployments[0].Metadata.Name
    }
  }
  Context 'Selectors' {
    It 'Gets some deployments based on labels' {
      $d = Get-K8sDeployment -l 'app=docker-registry'
      $d.Count | Should -Be 1
    }
    It 'Gets some deployments based on fields' {
      $d = Get-K8sDeployment -FieldSelector 'metadata.name=registry-docker-registry'
      $d.Count | Should -Be 1
    }
  }
}