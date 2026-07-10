variable "mi_ip_publica" {
  type        = string
  description = "Tu IP pública de internet seguida de /32"
  default     = "0.0.0.0/0" # Reemplázala por tu IP real si la sabes para mayor seguridad
}

variable "mi_ami_id" {
  type        = string
  description = "El ID de la AMI generada en tu actividad anterior"
  default     = "ami-xxxxxxxxxxxxxxxxx" # <-- PEGA AQUÍ TU AMI REAL
}
