variable "postgres_password" {
  description = "Password for the PostgreSQL superuser"
  type        = string
  sensitive   = true
}

variable "postgres_replication_password" {
  description = "Replication password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint for the primary cluster."
  type        = string
}

variable "cluster_ca_certificate" {
  description = "EKS cluster CA certificate for the primary cluster."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name for the primary cluster."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace where"
  type        = string
  default     = "postgres-ha"
}

variable "values_yaml_path" {
  description = "Path to the values.yaml file for the Helm chart"
  type        = string
}

variable "etcd_endpoint" {
  description = "ETCD Load Balancer DNS"
  type        = string
}