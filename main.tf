provider "aws" {
  region = var.provider_region
}

module "vpc" {
  source   = "./modules/vpc"
  prefix = var.prefix
  vpc_cidr = var.vpc_cidr
}

module "eks_cluster_1" {
  source  = "./modules/eks"

  cluster_name             = var.cluster_name_1
  vpc_id                   = module.vpc.vpc_id
  private_subnets          = module.vpc.private_subnet_ids
  eks_node_type            = var.eks_node_type
  eks_node_desired_size    = var.eks_node_desired_size
}

module "eks_cluster_2" {
  source  = "./modules/eks"

  cluster_name             = var.cluster_name_2
  vpc_id                   = module.vpc.vpc_id
  private_subnets          = module.vpc.private_subnet_ids
  eks_node_type            = var.eks_node_type
  eks_node_desired_size    = var.eks_node_desired_size
}

module "postgres_primary" {
  source                         = "./modules/db-primary"
  cluster_name                   = var.cluster_name_1
  cluster_endpoint               = module.eks_cluster_1.cluster_endpoint
  cluster_ca_certificate         = module.eks_cluster_1.cluster_certificate_authority
  postgres_password              = var.postgres_password
  postgres_replication_password  = var.postgres_replication_password
  provider_region                = var.provider_region
  storage_size                   = var.storage_size
  namespace                      = var.namespace
  replica_count                  = var.replica_count
  database_name                  = var.database_name
}

module "postgres_standby" {
  source                         = "./modules/db-standby"
  cluster_name                   = var.cluster_name_2
  cluster_endpoint               = module.eks_cluster_2.cluster_endpoint
  cluster_ca_certificate         = module.eks_cluster_2.cluster_certificate_authority
  postgres_password              = var.postgres_password
  postgres_replication_password  = var.postgres_replication_password
  primary_host                   = module.postgres_primary.primary_load_balancer_dns
  storage_size                   = var.storage_size
  namespace                      = var.namespace
  database_name                  = var.database_name

}

