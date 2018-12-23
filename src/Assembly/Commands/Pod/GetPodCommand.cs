using System;
using System.Management.Automation;
using k8s;
using k8s.Models;
using PowerKube.Commands.Base;

namespace PowerKube.Commands.Pod
{
    [Cmdlet(VerbsCommon.Get, "K8sPod")]
    public class GetPodCommand : K8sGetCommand
    {
        protected override void ProcessRecord()
        {
            IKubernetes client = Helpers.GetClientObj(KubeConfig, Context);
            WriteDebug(String.Format("Name is {0}", Name));
            string lblsel = Helpers.GetLabelSelector(LabelSelector);
            WriteDebug(String.Format("Label selector string is {0}", lblsel));
            string fldsel = Helpers.GetFieldSelector(Name, FieldSelector);
            WriteDebug(String.Format("Field selector string is {0}", fldsel));
            V1PodList podList;
            if (AllNamespaces)
            {
                WriteDebug("Getting pods from all namespaces");
                podList = client.ListPodForAllNamespaces(labelSelector: lblsel, fieldSelector: fldsel, includeUninitialized: true);
            } else
            {
                podList = client.ListNamespacedPod(Namespace, labelSelector: lblsel, fieldSelector: fldsel, includeUninitialized: true);
            }
            foreach (V1Pod item in podList.Items)
            {
                WriteObject(item);
            }
        }
    }
}
