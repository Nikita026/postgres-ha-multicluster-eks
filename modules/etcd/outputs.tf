output "etcd_endpoint" {
  value = data.kubernetes_service.etcd_lb.status[0].load_balancer[0].ingress[0].hostname
}

