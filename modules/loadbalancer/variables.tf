variable "sg_alb_id" {
  type        = string
  description = "ID del security group del Load Balancer"
}

variable "public_subnet_1_id" {
  type        = string
  description = "ID de la primera subnet publica (zona A)"
}

variable "public_subnet_2_id" {
  type        = string
  description = "ID de la segunda subnet publica (zona B) — el ALB requiere al menos 2 AZs"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se crea el Target Group"
}

variable "app_instance_id" {
  type        = string
  description = "ID de la instancia del servidor de App para registrarla en el ALB"
}
