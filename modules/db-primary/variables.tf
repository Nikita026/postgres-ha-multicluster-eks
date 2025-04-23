variable "provider_region" {
  description = "The AWS Region"
  type        = string
  default     = "us-east-1"
}

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

variable "storage_size" {
  description = "Size of the primary PostgreSQL persistent volume"
  type        = string
  default     = "8Gi"
}

variable "replica_count" {
  description = "Number of read replicas for the PostgreSQL instance"
  type        = number
  default     = 0
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