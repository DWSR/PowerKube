using System;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Text.RegularExpressions;
using k8s;

namespace PowerKube.Commands
{
    [Cmdlet(VerbsCommon.Switch, "K8sContext")]
    [OutputType(typeof(void))]
    public class SwitchContextCommand : Cmdlet
    {
        [Parameter(Mandatory = true, Position = 0)]
        public string Context { get; set; }
        [Parameter()]
        public string KubeConfig { get; set; }

        protected override void ProcessRecord()
        {
            k8s.KubeConfigModels.K8SConfiguration config = KubernetesClientConfiguration.LoadKubeConfig(KubeConfig);
            var contexts = config.Contexts.Select(i => i.Name);
            if (contexts.Contains(Context))
            {
                string cfgFile = File.ReadAllText(config.FileName);
                cfgFile = Regex.Replace(cfgFile, "current-context: .+", String.Format("current-context: {0}", Context));
                File.WriteAllText(config.FileName, cfgFile);
            }
            else
            {
                ErrorRecord errorRecord = new ErrorRecord(new ArgumentException("Must provide a context that is already present in the specified config file."), "Context", ErrorCategory.InvalidArgument, null);
                ThrowTerminatingError(errorRecord);
            }
        }
    }
}
