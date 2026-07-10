resource "aws_instance" "servidor_actividad" {
  ami                    = var.ami_id
  instance_type          = "t2.micro" # El tipo de instancia económica por defecto
  vpc_security_group_ids = [var.grupo_seguridad_id]

  tags = {
    Name = "Servidor-Modularizado"
  }
}
