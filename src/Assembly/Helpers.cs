using System;
using System.Reflection;
using System.Linq;
using k8s;
using k8s.Models;
using k8s.KubeConfigModels;

namespace PowerKube
{
    class Helpers
    {
        public static string GetConfigFilePath(string configFile = null)
        {
            if (string.IsNullOrEmpty(configFile)) {
                string filePathEnv = Environment.GetEnvironmentVariable("KUBECONFIG");
                if (! string.IsNullOrEmpty(filePathEnv))
                {
                    filePathEnv.Replace("~", Environment.GetFolderPath(Environment.SpecialFolder.UserProfile));
                }
                return filePathEnv;
            } else
            {
                return configFile;
            }
        }
        public static IKubernetes GetClientObj(string kubeConfig = null, string context = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(kubeConfig, context);
            return new Kubernetes(config);
        }
        public static K8SConfiguration GetConfigObj(string kubeConfig = null)
        {
            return KubernetesClientConfiguration.LoadKubeConfig(GetConfigFilePath(kubeConfig));
        }
        public static string GetCurrentNamespace(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(GetConfigFilePath(configFile));
            string ns = string.IsNullOrEmpty(config.Namespace) ? "default" : config.Namespace;
            return ns;
        }
        public static string GetCurrentContext(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(configFile);
            return config.CurrentContext;
        }
        public static V1APIResourceList GetApiResources(string configFile = null, string context = null)
        {
            IKubernetes client = Helpers.GetClientObj(configFile, context);
            V1APIResourceList resources = client.GetAPIResources();
            return resources;
        }
        public static V1APIVersions GetApiVersions(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(configFile);
            IKubernetes client = new Kubernetes(config);
            V1APIVersions versions = client.GetAPIVersions();
            return versions;
        }
        public static V1APIVersions GetApiVersions(string kubeConfig, string context = null)
        {
            IKubernetes client = GetClientObj(kubeConfig, context);
            return GetApiVersions(client);
        }
        public static V1APIVersions GetApiVersions(IKubernetes client)
        {
            return client.GetAPIVersions();
        }
        public static V1NamespaceList GetAllNamespaces(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(configFile);
            return GetAllNamespaces(config);
        }
        public static V1NamespaceList GetAllNamespaces(KubernetesClientConfiguration config)
        {
            IKubernetes client = new Kubernetes(config);
            return GetAllNamespaces(client);
        }
        public static V1NamespaceList GetAllNamespaces(IKubernetes client)
        {
            return client.ListNamespace();
        }
        public static string GetLabelSelector(string[] LabelSelector)
        {
            if (LabelSelector != null)
            {
                return string.Join(",", LabelSelector);
            } else
            {
                return String.Empty;
            }
        }
        public static string GetFieldSelector(string Name, string[] FieldSelector)
        {
            if (FieldSelector != null && !String.IsNullOrEmpty(Name))
            {
                var fldSelectors = new string[FieldSelector.Length + 1];
                fldSelectors[0] = String.Format("metadata.name={0}", Name);
                FieldSelector.CopyTo(fldSelectors, 1);
                return string.Join(",", fldSelectors);
            } else if (!String.IsNullOrEmpty(Name))
            {
                return String.Format("metadata.name={0}", Name);
            } else if (FieldSelector != null)
            {
                return string.Join(",", FieldSelector);
            } else // Both parameters must be empty
            {
                return String.Empty;
            }
        }
        public static V1APIGroupList GetApiGroups(IKubernetes client)
        {
            return client.GetAPIVersions1();
        }
        public static MethodInfo ResolveGetApiGroupFunctionForVersion(string apiGroup)
        {
            MethodInfo[] methods = typeof(KubernetesExtensions).GetMethods().Where(x => x.Name.Contains("GetAPIGroup")).ToArray();
            foreach (MethodInfo method in methods)
            {
                switch (apiGroup)
                {
                    case "extensions/v1beta1":
                        return null;
                    default:
                        throw new ArgumentException(string.Format("Cannot resolve library function to retrieve API group {0}", apiGroup));
                }
            }
            return null;
        }
    }
}
