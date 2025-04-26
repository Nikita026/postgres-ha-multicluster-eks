resource "helm_release" "etcd" {
  name       = "etcd"
  namespace  = "etcd"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "etcd"
  version    = "11.3.0"

  create_namespace = true

  set {
    name  = "replicaCount"
    value = var.etcd_replica_count
  }

  set {
    name  = "auth.token.enabled"
    value = "false"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = var.etcd_storage_size
  }

  set {
    name  = "persistence.storageClass"
    value = "gp2"
  }

  set {
    name  = "auth.rbac.enabled"
    value = "false"
  }

  set {
    name  = "auth.rbac.create"
    value = "false"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
    value = "\"true\""
  }

}

data "kubernetes_service" "etcd_lb" {
  metadata {
    name      = "etcd"
    namespace = "etcd"
  }
  depends_on = [helm_release.etcd]
}
