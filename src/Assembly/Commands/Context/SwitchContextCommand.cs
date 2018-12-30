using System;
using System.IO;
using System.Linq;
using System.Management.Automation;
using YamlDotNet.Serialization;
using k8s.KubeConfigModels;
using PowerKube.Commands.Base;

namespace PowerKube.Commands.Context
{
  [Cmdlet(VerbsCommon.Switch, "K8sContext")]
  [OutputType(typeof(void))]
  public class SwitchContextCommand : BaseContextCommand
  {
    [Parameter(Mandatory = true, Position = 0)]
    public new string Context { get; set; }

    protected override void ProcessRecord()
    {
      K8SConfiguration config = Helpers.GetConfigObj(KubeConfig);
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
