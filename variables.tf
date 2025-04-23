variable "provider_region" {
  description = "The AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "Name prefix"
  type        = string
  default     = "test"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "cluster_name_1" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_name_2" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_node_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "t3.small"
}

variable "eks_node_desired_size" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 2
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