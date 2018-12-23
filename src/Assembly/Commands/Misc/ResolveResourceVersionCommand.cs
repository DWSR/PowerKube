using System;
using System.Linq;
using System.Management.Automation;
using k8s;
using k8s.Models;
using PowerKube.Commands.Base;

namespace PowerKube.Commands.Misc
{
    [Cmdlet(VerbsDiagnostic.Resolve, "K8sResourceVersion")]
    [OutputType(typeof(string))]
    public class ResolveResourceVersionCommand : K8sBaseCommand
    {
        [Parameter(Mandatory = true, Position = 0)]
        public string ResourceName { get; set; }
        protected override void ProcessRecord()
        {
            IKubernetes client = Helpers.GetClientObj(KubeConfig, Context);
            V1APIResourceList v1ResourceList = client.GetAPIResources();
            WriteDebug(String.Format("Found {0} resources in v1 API", v1ResourceList.Resources.Count()));
            // V1APIGroupList v1GroupList = Helpers.GetApiGroups(client);
            // If the resource list contains the specified resource name as one of the short names,
            // the plural name, or the singular name
            if (v1ResourceList.Resources.Where(
                    x => string.Equals(x.Kind, ResourceName, StringComparison.OrdinalIgnoreCase) ||
                    string.Equals(x.Name, ResourceName, StringComparison.OrdinalIgnoreCase) ||
                    x.ShortNames.Contains(ResourceName, StringComparer.OrdinalIgnoreCase)
               ) is var res && res.Count() >= 1)
            {
                WriteDebug(res.First().Name);
                WriteObject(String.IsNullOrEmpty(res.First().Version) ? "v1" : res.First().Version);
            }
        }
    }
}
