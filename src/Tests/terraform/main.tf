# Variables
###
variable "cluster_name" {
  description = "The name of the Kubernetes cluster. Must be unique."
}

# Providers
###

provider "local" {}

provider "digitalocean" {
  version = "~> 1.1"
}

provider "kubernetes" {
  version = "~> 1.4"

  host                   = "${digitalocean_kubernetes_cluster.cluster.endpoint}"
  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
}

provider "helm" {
  version = "~> 0.7"

  namespace       = "kube-system"
  install_tiller  = true
  service_account = "tiller"
  insecure        = "true"

  kubernetes {
    host                   = "${digitalocean_kubernetes_cluster.cluster.endpoint}"
    client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
    client_key             = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
    cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
  }
}

# Resources
###

resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.cluster_name}"
  region  = "nyc1"
  version = "1.13.1-do.2"

  node_pool {
    name       = "${var.cluster_name}-pool"
    size       = "s-1vcpu-2gb"
    node_count = 1
  }
}

resource "local_file" "kubeconfig" {
  content  = "${digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config}"
  filename = "${path.module}/kubeconfig"

  lifecycle {
    ignore_changes = [
      "content",
    ]
  }
}

resource "kubernetes_service_account" "tiller_sa" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller_binding" {
  metadata {
    name = "tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
    api_group = ""
  }
}

resource "helm_release" "registry_deployment" {
  name          = "registry"
  chart         = "stable/docker-registry"
  namespace     = "default"
  recreate_pods = true
  reuse         = true
  force_update  = true

  values = [
    "${file("${path.module}/registry-deployment.yml")}",
  ]

  depends_on = [
    "kubernetes_cluster_role_binding.tiller_binding",
    "kubernetes_service_account.tiller_sa",
  ]
}
