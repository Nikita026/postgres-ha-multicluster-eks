resource "helm_release" "postgres_standby" {
  name             = "pg-standby"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "postgresql"
  version          = "16.6.3"
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "architecture"
    value = "replication"
  }

  set {
    name  = "auth.username"
    value = "postgres"
  }

  set {
    name  = "auth.postgresPassword"
    value = var.postgres_password
  }

  set {
    name  = "auth.replicationPassword"
    value = var.postgres_replication_password
  }

  set {
    name  = "auth.database"
    value = var.database_name
  }

  set {
    name  = "readReplicas.replicaCount"
    value = "0"
  }

  set {
    name  = "primary.standby.enabled"
    value = "true"
  }

  set {
    name  = "primary.standby.primaryHost"
    value = var.primary_host
  }

  set {
    name  = "primary.standby.primaryPort"
    value = "5432"
  }

  set {
    name  = "primary.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "primary.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
    value = "\"true\""
  }

  set {
    name  = "primary.persistence.enabled"
    value = "true"
  }

  set {
    name  = "primary.persistence.size"
    value = var.storage_size
  }

  set {
    name  = "primary.persistence.storageClass"
    value = "gp2"
  }

  set {
    name  = "pgHbaConfiguration"
    value = "host replication all 0.0.0.0/0 md5"
  }
}

