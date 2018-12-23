using System;
using System.Management.Automation;

namespace PowerKube.Commands.Base
{
    [CmdletBinding(DefaultParameterSetName = "OneNamespace")]
    public abstract class K8sGetCommand : K8sBaseCommand
    {
        [Parameter(ParameterSetName = "OneNamespace")]
        public string Namespace { get; set; } = Helpers.GetCurrentNamespace();
        [Parameter(Position = 0)]
        public string Name { get; set; }
        [Parameter()]
        [Alias("l")]
        public string[] LabelSelector { get; set; }
        [Parameter()]
        public string[] FieldSelector { get; set; }
        [Parameter(Mandatory = true, ParameterSetName = "AllNamespaces")]
        public SwitchParameter AllNamespaces { get; set; }
        [Parameter()]
        public string APIVersion { get; set; }
    }
}
