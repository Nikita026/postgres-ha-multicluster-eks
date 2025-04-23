# PostgreSQL HA Setup with Terraform on EKS

This project demonstrates how to set up a highly available PostgreSQL database using Terraform and Helm on Amazon EKS (Elastic Kubernetes Service). The setup includes primary and standby PostgreSQL clusters deployed across multiple EKS clusters for high availability.

## Prerequisites

Before you begin, make sure you have the following:

- **AWS Account** with proper IAM permissions
- **Terraform** installed (v1.0+)
- **kubectl** installed and configured
- **Helm** installed
- **AWS CLI** installed and configured

## Project Structure

The project is structured into modules for easier management and maintenance:

```
postgres-ha-multicluster-eks/
├── main.tf          # Main Terraform configuration for the entire setup
├── outputs.tf       # Outputs from Terraform resources (like LoadBalancer DNS, VPC details)
├── variables.tf     # Terraform variables, including cluster name, VPC, node types, etc.
├── modules/         
│   ├── eks          # EKS module for managing EKS cluster
│   ├── vpc          # VPC module for managing VPC and subnets
│   ├── db-primary   # PostgreSQL primary database setup
│   └── db-standby   # PostgreSQL standby database setup
├── README.md        # Project documentation explaining how to set up and deploy
├── .gitignore       # Git ignore file to exclude unnecessary files from version control
└── terraform.tfvars # (Optional) Variable values for deployment, sensitive information like passwords

```
## Deployment Steps

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/postgres-ha-multicluster-eks.git
cd postgres-ha-multicluster-eks
```

### 2. Configure Variables

Create a file named `terraform.tfvars` to define your custom values for the deployment:

```bash
touch terraform.tfvars
```

Add the following content to `terraform.tfvars`:

```hcl
provider_region = "us-east-1"
prefix          = "test"
vpc_cidr        = "10.0.0.0/16"
cluster_name_1    = "cluster1"
cluster_name_2    = "cluster2"
eks_node_type   = "t3.small"
eks_node_desired_size = 2
postgres_password            = ""
postgres_replication_password = ""
storage_size = "5Gi"
replica_count = "1"
namespace = "postgres-ha"
database_name = "mydb"
```

### 3. Initialize Terraform

Run the following command to initialize Terraform and download necessary provider plugins:

```bash
terraform init
```

### 4. Apply Terraform Configuration

Run the following command to apply the Terraform configuration and deploy the PostgreSQL HA setup:

```bash
terraform apply -var="postgres_password=yourpassword" -var="postgres_replication_password=yourreplicationpassword"
```

Terraform will prompt you to confirm before applying the changes. Type `yes` to continue.

### 5. Verify Deployment

Once the Terraform apply is successful, verify that the PostgreSQL primary and standby clusters are up and running. You can check the status by querying the services in Kubernetes:

```bash
kubectl get svc -n postgres-ha
```

Ensure that the `pg-primary-postgresql-primary` service and `pg-standby-postgresql-standby` service are listed.

### 6. Access PostgreSQL Database

You can access the PostgreSQL service through the load balancer's DNS (which will be printed by Terraform). For example:

```bash
kubectl get svc pg-primary-postgresql-primary -n postgres-ha
```

Check the `EXTERNAL-IP` column to get the DNS of your primary PostgreSQL service.

### 7. Monitor PostgreSQL

You can monitor PostgreSQL using standard Kubernetes tools like `kubectl logs` or through AWS CloudWatch if logging is set up.

```bash
kubectl logs -f <postgres-primary-pod-name> -n postgres-ha
```

## Cleanup

To destroy the resources created by Terraform, run:

```bash
terraform destroy
```

Confirm the action by typing `yes`.

## Troubleshooting

- **Kubernetes Service Not Found**: Ensure that the namespace and service names match your configuration. You can list all services with:

    ```bash
    kubectl get svc -n postgres-ha
    ```

- **Pod Failures**: If pods fail to start, check the logs for errors:

    ```bash
    kubectl logs <pod-name> -n postgres-ha
    ```

