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

variable "etcd_replica_count" {
  description = "Number of etcd replicas"
  type        = number
  default     = 2
}

variable "etcd_storage_size" {
  description = "Persistent volume size for etcd"
  type        = string
  default     = "5Gi"
}
