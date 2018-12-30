using System;
using System.Management.Automation;
using System.Linq;
using k8s.KubeConfigModels;
using PowerKube.Commands.Base;

namespace PowerKube.Commands.Context
{
    [Cmdlet(VerbsCommon.Get, "K8sContext")]
    [OutputType(typeof(k8s.KubeConfigModels.Context))]
    public class GetContextCommand : BaseContextCommand
    {
        protected override void ProcessRecord()
        {
            K8SConfiguration config = Helpers.GetConfigObj(KubeConfig);
            WriteDebug(string.Format("Found {0} contexts", config.Contexts.Count()));
            if (string.IsNullOrEmpty(Context))
            {
                foreach (var context in config.Contexts)
                {
                    WriteObject(context);
                }
            }
            else
            {
                WriteObject(config.Contexts.Where(i => i.Name == Context));
            }
        }
    }
}
