using System;
using System.Management.Automation;
using PowerKube.Commands.Base;
using k8s;
using k8s.Models;

namespace PowerKube.Commands.Pod
{
    [Cmdlet(VerbsCommon.Remove, "K8sPod")]
    public class RemovePodCommand : K8sRemoveCommand
    {
        [Parameter()]
        override public string APIVersion { get; set; } = "v1";

        protected override void BeginProcessing()
        {
            if (InputObject != null)
            {
                WriteDebug("Processing input from pipeline");
            }
        }
        protected override void ProcessRecord()
        {
            IKubernetes client = Helpers.GetClientObj(KubeConfig, Context);
            V1PodList pods;
            if (InputObject != null)
            {
                V1Pod pod = (V1Pod)InputObject.BaseObject;
                WriteVerbose(string.Format("Removed pod {0}", pod.Metadata.Name));
                client.DeleteNamespacedPod(new V1DeleteOptions(), pod.Metadata.Name, pod.Metadata.NamespaceProperty, GracePeriod, null, PropagationPolicy.ToString());
                return;
            }
            else if (All)
            {
                WriteDebug(string.Format("Removing all pods in namespace {0}", Namespace));
                pods = client.ListNamespacedPod(Namespace, null, null, true);
            }
            else
            {
                WriteDebug(string.Format("Removing specific pods from namespace {0}", Namespace));
                (string lblsel, string fldsel) = GetSelectors();
                pods = client.ListNamespacedPod(Namespace, null, fldsel, true, lblsel);
            }
            foreach (var pod in pods.Items)
            {
                client.DeleteNamespacedPod(new V1DeleteOptions(), pod.Metadata.Name, Namespace, GracePeriod, null, PropagationPolicy.ToString());
                WriteVerbose(string.Format("Removed pod {0}", pod.Metadata.Name));
            }
        }
    }
}
