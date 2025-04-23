output "primary_host" {
  value = module.postgres_primary.primary_load_balancer_dns
}

