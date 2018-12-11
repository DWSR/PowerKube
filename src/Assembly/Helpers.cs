using System;
using k8s;
using k8s.Models;

namespace PowerKube
{
    class Helpers
    {
        public static string GetCurrentNamespace(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(configFile);
            string ns = string.IsNullOrEmpty(config.Namespace) ? "default" : config.Namespace;
            return ns;
        }
        public static string GetCurrentContext(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(configFile);
            return config.CurrentContext;
        }
        public static V1APIResourceList GetApiResources(string configFile = null)
        {
            KubernetesClientConfiguration config = KubernetesClientConfiguration.BuildConfigFromConfigFile(configFile);
            IKubernetes client = new Kubernetes(config);
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
    }
}
