resource "helm_release" "stolon" {
  name             = "stolon"
  namespace        = var.namespace
  create_namespace = true

  chart = "${path.module}/stolon-helm"

  values = [
    templatefile("${path.module}/${var.values_yaml_path}", {
      postgres_password             = var.postgres_password
      postgres_replication_password = var.postgres_replication_password
      etcd_endpoint                 = var.etcd_endpoint
    })
  ]
  set {
    name  = "postgresqlPassword"
    value = var.postgres_password
  }

  set {
    name  = "replicationPassword"
    value = var.postgres_replication_password
  }

  set {
    name  = "store.endpoints"
    value = "http://${var.etcd_endpoint}:2379"
  }
}
