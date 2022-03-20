resource "helm_release" "dashboard" {
  name = "dashboard"

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  namespace  = "kube-system"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "protocolHttp"
    value = "true"
  }

  set {
    name  = "service.externalPort"
    value = 443
  }

  set {
    name  = "replicaCount"
    value = 2
  }

  set {
    name  = "rbac.clusterReadOnlyRole"
    value = "true"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.cluster,
    kubernetes_config_map.aws_auth
  ]
}