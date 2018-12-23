Describe 'Get-K8sPod' {
  Context 'General Functionality' {
    It 'Gets pods' {
      $p = Get-K8sPod
      $p | Should -BeOfType k8s.Models.V1Pod
      $p.Count | Should -BeGreaterOrEqual 5
    }
    It 'Gets pods in a different namespace' {
      $p = Get-K8sPod -Namespace 'kube-system'
      $q = Get-K8sPod
      $p.Count | Should -BeGreaterOrEqual 5
      $p[0].Metadata.Name | Should -Not -Be $q[0].Metadata.Name
    }
    It 'Gets pods in all namespaces' {
      $p = Get-K8sPod -AllNamespaces
      $p.Count | Should -BeGreaterOrEqual 10
    }
    It 'Gets a specific pod' {
      $allPods = Get-K8sPod
      $aPod = $allPods[0]
      $samePod = Get-K8sPod -Name $aPod.Metadata.Name
      $samePod.Metadata.Name | Should -Be $aPod.Metadata.Name
    }
  }
  Context 'Selectors' {
    It 'Gets some pods based on labels' {
      $p = Get-K8sPod -LabelSelector 'app=docker-registry'
      $p.Count | Should -BeGreaterOrEqual 5
    }
    It 'Gets some pods based on fields' {
      $p = Get-K8sPod -FieldSelector 'status.phase=Running'
      $p.Count | Should -BeGreaterOrEqual 5
    }
  }
}