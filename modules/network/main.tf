# Creamos un grupo de seguridad en AWS
resource "aws_security_group" "seguridad_actividad" {
  name        = "seguridad-ejercicio-1"
  description = "Permite acceso SSH seguro"

  # Regla de entrada: Permite conectarte por SSH (Puerto 22) solo desde tu IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mi_ip_publica]
  }

  # Regla de salida: Permite que el servidor tenga internet para actualizarse
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
