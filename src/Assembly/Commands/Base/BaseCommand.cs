using System;
using System.Management.Automation;

namespace PowerKube.Commands.Base
{
    public class K8sBaseCommand : Cmdlet
    {
        [Parameter()]
        public string Context { get; set; }
        [Parameter()]
        public string Cluster { get; set; }
        [Parameter()]
        public string KubeConfig { get; set; } = Helpers.GetConfigFilePath();
        [Parameter()]
        public SwitchParameter SkipCertificateCheck { get; set; }
    }
}
