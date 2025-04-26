module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access = true

  create_kms_key              = false
  create_cloudwatch_log_group = false
  cluster_encryption_config   = {}

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.private_subnets

  eks_managed_node_groups = {
    "${var.cluster_name}-ng" = {
      ami_type        = "AL2_x86_64"
      instance_types  = [var.eks_node_type]
      min_size        = 1
      max_size        = 5
      desired_size    = var.eks_node_desired_size
      create_iam_role = true
      iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        AmazonEBSCSIDriverPolicy     = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      vpc_security_group_ids = [resource.aws_security_group.psql_sg.id]
      tags = {
        Name = "${var.cluster_name}-ng"
      }
    }
  }


  enable_cluster_creator_admin_permissions = true

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_security_group" "psql_sg" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS node group allowing PostgreSQL access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr] # Allow traffic from VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-node-sg"
  }
}
