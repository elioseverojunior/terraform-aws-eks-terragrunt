resource "helm_release" "chaos_mesh" {
  name             = "chaos-mesh"
  chart            = "chaos-mesh"
  repository       = "https://charts.chaos-mesh.org"
  namespace        = "chaos-testing"
  create_namespace = true

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.cluster,
    kubernetes_config_map.aws_auth
  ]
}