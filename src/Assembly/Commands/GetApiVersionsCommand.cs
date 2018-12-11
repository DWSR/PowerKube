using System;
using System.Management.Automation;
using k8s;
using k8s.Models;

namespace PowerKube.Commands
{
    [Cmdlet(VerbsCommon.Get, "K8sApiVersions")]
    public class GetApiVersionsCommand : BaseK8sCommand
    {
        [Parameter(Position = 0)]
        public string Name { get; set; }
        protected override void ProcessRecord()
        {
            WriteObject(Helpers.GetApiVersions(KubeConfig));
        }
    }
}
