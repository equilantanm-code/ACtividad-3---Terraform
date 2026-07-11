output "security_group_id" {
  description = "ID del security group del servidor de App"
  value       = aws_security_group.sg_app.id
}

output "sg_alb_id" {
  description = "ID del security group del Load Balancer"
  value       = aws_security_group.sg_alb.id
}

output "sg_mongodb_id" {
  description = "ID del security group de MongoDB"
  value       = aws_security_group.sg_mongodb.id
}

output "public_subnet_1_id" {
  description = "ID de la subnet publica 1 (App)"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "ID de la subnet publica 2 (ALB segunda zona)"
  value       = aws_subnet.public_2.id
}

output "private_subnet_id" {
  description = "ID de la subnet privada (MongoDB)"
  value       = aws_subnet.private.id
}

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "nat_gateway_public_ip" {
  description = "IP publica del NAT Gateway (usada por MongoDB para salir a internet)"
  value       = aws_eip.nat.public_ip
}
