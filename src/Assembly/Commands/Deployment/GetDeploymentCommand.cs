using System;
using System.Management.Automation;
using k8s;
using k8s.Models;
using PowerKube.Commands.Base;

namespace PowerKube.Commands.Deployment
{
    [Cmdlet(VerbsCommon.Get, "K8sDeployment")]
    // [OutputType(typeof(Extensionsv1beta1Deployment))]
    public class GetDeploymentCommand : K8sGetCommand
    {
        protected override void ProcessRecord()
        {
            IKubernetes client = Helpers.GetClientObj(KubeConfig, Context);
            WriteDebug(String.Format("Name is {0}", Name));
            string lblsel = Helpers.GetLabelSelector(LabelSelector);
            WriteDebug(String.Format("Label selector string is {0}", lblsel));
            string fldsel = Helpers.GetFieldSelector(Name, FieldSelector);
            WriteDebug(String.Format("Field selector string is {0}", fldsel));
            Extensionsv1beta1DeploymentList list;
            if (AllNamespaces)
            {
                WriteDebug("Getting deployments from all namespaces");
                list = client.ListDeploymentForAllNamespaces3(labelSelector: lblsel, fieldSelector: fldsel, includeUninitialized: true);
            } else
            {
                list = client.ListNamespacedDeployment3(Namespace, labelSelector: lblsel, fieldSelector: fldsel, includeUninitialized: true);
            }
            WriteDebug(String.Format("Found {0} deployments", list.Items.Count));
            foreach (Extensionsv1beta1Deployment item in list.Items)
            {
                WriteObject(item);
            }
        }
    }
}
