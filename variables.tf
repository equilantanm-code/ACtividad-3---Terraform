variable "mi_ip_publica" {
  type        = string
  description = "Tu IP publica de internet seguida de /32 (ej: 203.0.113.10/32)"
  default     = "0.0.0.0/0" # Reemplázala por tu IP real para mayor seguridad
}

variable "ami_id_app" {
  type        = string
  description = "ID de la AMI para el servidor de App (Nginx + Node.js)"
  default     = "ami-02b45bd5337cf4c7d"
}

variable "ami_id_mongodb" {
  type        = string
  description = "ID de la AMI para el servidor MongoDB"
  default     = "ami-0b9f194596a5bb769"
}

variable "key_name" {
  type        = string
  description = "Nombre del Key Pair de AWS para acceso SSH a las instancias"
  default     = "mi-keypair" # <-- nombre que le di a mi par de llaves
}

variable "region" {
  type        = string
  description = "Region de AWS donde se desplegara toda la infraestructura"
  default     = "us-east-1"
}
