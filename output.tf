# ─── Ejercicio 3: Outputs de Terraform ───────────────────────────────────────

output "ip_publica_servidor_app" {
  description = "IP publica del servidor de App (Nginx + Node.js)"
  value       = module.mi_computo.app_public_ip
}

output "ip_privada_servidor_app" {
  description = "IP privada del servidor de App dentro de la VPC"
  value       = module.mi_computo.app_private_ip
}

output "ip_privada_mongodb" {
  description = "IP privada del servidor MongoDB (solo accesible desde dentro de la VPC)"
  value       = module.mi_computo.mongodb_private_ip
}

output "dns_balanceador" {
  description = "DNS publico del Application Load Balancer — usa esta URL para acceder a la app"
  value       = module.mi_balanceador.alb_dns_name
}

output "ip_publica_nat_gateway" {
  description = "IP publica del NAT Gateway (la IP con la que MongoDB sale a internet)"
  value       = module.mi_red.nat_gateway_public_ip
}
