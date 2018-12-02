using System;
using System.Management.Automation;
using k8s;
using k8s.Models;

namespace PowerKube
{
    [Cmdlet(VerbsCommon.Get, "K8sPod")]
    public class GetPodCommand : BaseK8sCommand
    {
        [Parameter(Position = 0)]
        public string Name { get; set; }
        protected override void ProcessRecord()
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(KubeConfig, Context); 
            IKubernetes client = new Kubernetes(config);
            V1PodList list = client.ListNamespacedPod(Namespace);
            foreach (V1Pod item in list.Items)
            {
                WriteObject(item);
            }
        }
    }
}
