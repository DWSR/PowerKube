using System;
using System.Management.Automation;
using k8s;
using k8s.Models;

namespace PowerKube.Commands
{
    [Cmdlet(VerbsCommon.Get, "K8sDeployment")]
    public class GetDeploymentCommand : BaseK8sCommand
    {
        [Parameter(Position = 0)]
        public string Name { get; set; }
        protected override void ProcessRecord()
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(KubeConfig, Context);
            IKubernetes client = new Kubernetes(config);
            V1DeploymentList list = client.ListNamespacedDeployment(Namespace);
            foreach (V1Deployment item in list.Items)
            {
                WriteObject(item);
            }
        }
    }
}
