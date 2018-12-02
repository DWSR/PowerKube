using System;
using k8s;

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
    }
}
