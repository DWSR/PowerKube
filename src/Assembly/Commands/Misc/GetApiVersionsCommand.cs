using System;
using System.Management.Automation;
using k8s;
using k8s.Models;
using System.Linq;
using PowerKube.Commands.Base;

namespace PowerKube.Commands.Misc
{
    [Cmdlet(VerbsCommon.Get, "K8sApiVersion")]
    [OutputType(typeof(string))]
    public class GetApiVersionsCommand : K8sBaseCommand
    {
        [Parameter(Position = 0)]
        public string Name { get; set; }
        protected override void ProcessRecord()
        {
            IKubernetes client = Helpers.GetClientObj(KubeConfig, Context);
            V1APIVersions apiVersions = Helpers.GetApiVersions(client);
            V1APIGroupList apiGroupList = Helpers.GetApiGroups(client);
            foreach (V1APIGroup group in apiGroupList.Groups)
            {
                foreach (string version in group.Versions.Select(i => i.GroupVersion))
                {
                    WriteObject(version);
                }
            }
            foreach (string ver in apiVersions.Versions)
            {
                WriteObject(ver);
            }
        }
    }
}
