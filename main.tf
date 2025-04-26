provider "aws" {
  region = var.provider_region
}

module "vpc" {
  source   = "./modules/vpc"
  prefix   = var.prefix
  vpc_cidr = var.vpc_cidr
}

module "eks_cluster_1" {
  source = "./modules/eks"

  cluster_name          = var.cluster_name_1
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnet_ids
  eks_node_type         = var.eks_node_type
  eks_node_desired_size = var.eks_node_desired_size
  vpc_cidr              = var.vpc_cidr
}

module "eks_cluster_2" {
  source = "./modules/eks"

  cluster_name          = var.cluster_name_2
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnet_ids
  eks_node_type         = var.eks_node_type
  eks_node_desired_size = var.eks_node_desired_size
  vpc_cidr              = var.vpc_cidr
}

module "etcd" {
  source = "./modules/etcd"

  cluster_endpoint       = module.eks_cluster_1.cluster_endpoint
  cluster_ca_certificate = module.eks_cluster_1.cluster_certificate_authority
  cluster_name           = var.cluster_name_1
  etcd_replica_count     = var.etcd_replica_count
  etcd_storage_size      = var.etcd_storage_size
}

module "stolon_1" {
  source = "./modules/stolon"

  cluster_endpoint              = module.eks_cluster_1.cluster_endpoint
  cluster_ca_certificate        = module.eks_cluster_1.cluster_certificate_authority
  cluster_name                  = var.cluster_name_1
  postgres_password             = var.postgres_password
  postgres_replication_password = var.postgres_replication_password
  etcd_endpoint                 = module.etcd.etcd_endpoint
  namespace                     = var.namespace
  values_yaml_path              = var.values1_yaml_path

}

module "stolon_2" {
  source = "./modules/stolon"

  cluster_endpoint              = module.eks_cluster_2.cluster_endpoint
  cluster_ca_certificate        = module.eks_cluster_2.cluster_certificate_authority
  cluster_name                  = var.cluster_name_2
  postgres_password             = var.postgres_password
  postgres_replication_password = var.postgres_replication_password
  etcd_endpoint                 = module.etcd.etcd_endpoint
  namespace                     = var.namespace
  values_yaml_path              = var.values2_yaml_path

}
