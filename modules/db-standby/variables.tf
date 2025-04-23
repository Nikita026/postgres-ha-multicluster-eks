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

variable "primary_host" {
  description = "Internal LoadBalancer DNS of the primary PostgreSQL service"
  type        = string
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

variable "storage_size" {
  description = "Size of the primary PostgreSQL persistent volume"
  type        = string
  default     = "8Gi"
}

variable "namespace" {
  description = "Kubernetes namespace where PostgreSQL is deployed"
  type        = string
  default     = "postgres-ha"
}

variable "database_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "mydb"
}