using System;
using System.Linq;
using System.Management.Automation;
using k8s;
using k8s.KubeConfigModels;

namespace PowerKube.Commands.Context
{
    [Cmdlet(VerbsCommon.Get, "K8sCurrentContext")]
    [OutputType(typeof(string))]
    public class GetCurrentContextCommand : Cmdlet
    {
        [Parameter()]
        public string KubeConfig { get; set; }

        [Parameter()]
        public SwitchParameter IncludeNamespace { get; set; }

        [Parameter()]
        public string NamespaceSeparator { get; set; } = "=>";

        protected override void ProcessRecord()
        {
            K8SConfiguration config = KubernetesClientConfiguration.LoadKubeConfig(Helpers.GetConfigFilePath(KubeConfig));
            if (IncludeNamespace)
            {
                string name = config.CurrentContext;
                string ctxNamespace = config.Contexts.Where(i => i.Name == config.CurrentContext).First().Namespace;
                if (string.IsNullOrEmpty(ctxNamespace))
                {
                    ctxNamespace = "default";
                }
                WriteObject(string.Format("{0}{1}{2}", name, NamespaceSeparator, ctxNamespace));
            } else
            {
                WriteObject(config.CurrentContext);
            }
        }
    }
}
