output "app_public_ip" {
  description = "IP publica del servidor de App (Nginx + Node.js)"
  value       = aws_instance.servidor_app.public_ip
}

output "app_private_ip" {
  description = "IP privada del servidor de App"
  value       = aws_instance.servidor_app.private_ip
}

output "mongodb_private_ip" {
  description = "IP privada del servidor MongoDB"
  value       = aws_instance.servidor_mongodb.private_ip
}

output "app_instance_id" {
  description = "ID de la instancia del servidor de App (para registrar en el ALB)"
  value       = aws_instance.servidor_app.id
}
