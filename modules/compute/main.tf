# Instancia 1: Servidor de aplicacion (Nginx + Node.js)
resource "aws_instance" "servidor_app" {
  ami                    = var.ami_id_app
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.sg_app_id]
  key_name               = var.key_name

  tags = {
    Name = "Servidor-App-NginxNode"
  }
}

# Instancia 2: Servidor MongoDB (en subnet privada)
resource "aws_instance" "servidor_mongodb" {
  ami                    = var.ami_id_mongodb
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.sg_mongodb_id]
  key_name               = var.key_name

  tags = {
    Name = "Servidor-MongoDB"
  }
}
