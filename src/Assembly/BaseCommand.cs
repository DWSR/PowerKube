using System;
using System.Management.Automation;

namespace PowerKube
{
    public class BaseK8sCommand : Cmdlet
    {
        [Parameter()]
        public string Namespace { get; set; } = Helpers.GetCurrentNamespace();
        [Parameter()]
        public string Context { get; set; }
        [Parameter()]
        public string Cluster { get; set; }
        [Parameter()]
        public string KubeConfig { get; set; }
        [Parameter()]
        public SwitchParameter SkipCertificateCheck { get; set; }
    }
}
