using System;
using System.Management.Automation;
using k8s.Models;
using PowerKube.Types;

namespace PowerKube.Commands.Base
{
    [CmdletBinding(DefaultParameterSetName = "RemoveMany")]
    public abstract class K8sRemoveCommand : K8sBaseCommand
    {
        [Parameter(Mandatory = true, ValueFromPipeline = true, ParameterSetName = "Pipeline")]
        public PSObject InputObject { get; set; }
        [Parameter(ParameterSetName = "RemoveMany")]
        [Parameter(ParameterSetName = "RemoveAll")]
        public string Namespace { get; set; } = Helpers.GetCurrentNamespace();
        [Parameter(Mandatory = true, Position = 0, ParameterSetName = "RemoveMany")]
        public string Name { get; set; }
        [Parameter(ParameterSetName = "RemoveMany")]
        [Parameter(ParameterSetName = "RemoveAll")]
        [Alias("l")]
        public string[] LabelSelector { get; set; }
        [Parameter(ParameterSetName = "RemoveMany")]
        [Parameter(ParameterSetName = "RemoveAll")]
        public string[] FieldSelector { get; set; }
        [Parameter()]
        [Alias("f")]
        public SwitchParameter Force { get; set; }
        [Parameter()]
        [ValidateRange((int)0, int.MaxValue)]
        public int GracePeriod { get; set; } = 10;
        [Parameter(Mandatory = true, ParameterSetName = "RemoveAll")]
        public SwitchParameter All { get; set; }
        [Parameter(ParameterSetName = "RemoveMany")]
        [Parameter(ParameterSetName = "RemoveAll")]
        public PropagationPolicy PropagationPolicy { get; set; } = PropagationPolicy.Background;
        [Parameter(ParameterSetName = "RemoveMany")]
        [Parameter(ParameterSetName = "RemoveAll")]
        public abstract string APIVersion { get; set; }

        internal (string lblsel, string fldsel) GetSelectors()
        {
            WriteDebug(String.Format("Name is {0}", Name));
            string lblsel = Helpers.GetLabelSelector(LabelSelector);
            WriteDebug(String.Format("Label selector string is {0}", lblsel));
            string fldsel = Helpers.GetFieldSelector(Name, FieldSelector);
            WriteDebug(String.Format("Field selector string is {0}", fldsel));
            return (lblsel, fldsel);
        }
    }
}
