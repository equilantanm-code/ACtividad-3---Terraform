variable "ami_id_app" {
  type        = string
  description = "AMI para el servidor de aplicacion (Nginx + Node.js)"
}

variable "ami_id_mongodb" {
  type        = string
  description = "AMI para el servidor MongoDB"
}

variable "sg_app_id" {
  type        = string
  description = "ID del security group del servidor de App"
}

variable "sg_mongodb_id" {
  type        = string
  description = "ID del security group de MongoDB"
}

variable "public_subnet_id" {
  type        = string
  description = "ID de la subnet publica donde se desplegara el servidor de App"
}

variable "private_subnet_id" {
  type        = string
  description = "ID de la subnet privada donde se desplegara MongoDB"
}

variable "key_name" {
  type        = string
  description = "Nombre del Key Pair de AWS para acceso SSH a las instancias"
}
