using System;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Text.RegularExpressions;
using YamlDotNet.Serialization;
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
        config.CurrentContext = Context;
        using (StreamWriter tr = File.CreateText(config.FileName))
        {
          var ser = new Serializer();
          ser.Serialize(tr, config);
        }
      }
      else
      {
        ErrorRecord errorRecord = new ErrorRecord(new ArgumentException("Must provide a context that is already present in the specified config file."), "Context", ErrorCategory.InvalidArgument, null);
        ThrowTerminatingError(errorRecord);
      }
    }
  }
}
