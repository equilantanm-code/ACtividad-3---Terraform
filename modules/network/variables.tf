variable "mi_ip_publica" {
  type        = string
  description = "Tu IP publica seguida de /32 (ej: 203.0.113.10/32)"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloque CIDR de la VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR de la subnet publica 1 (App + NAT)"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR de la subnet publica 2 (segunda AZ para el ALB)"
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR de la subnet privada (MongoDB)"
  default     = "10.0.3.0/24"
}

variable "region" {
  type        = string
  description = "Region de AWS (se usa para asignar availability zones)"
  default     = "us-east-1"
}
