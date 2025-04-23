output "primary_load_balancer_dns" {
  value = data.kubernetes_service.postgres_primary_lb.status[0].load_balancer[0].ingress[0].hostname
}

