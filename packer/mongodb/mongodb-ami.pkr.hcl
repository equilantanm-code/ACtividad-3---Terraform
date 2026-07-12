# =============================================================================
# Template Packer - AMI con MongoDB en AWS
# Genera una AMI reutilizable con MongoDB 7.x en Ubuntu 22.04 LTS (us-east-1)
# Uso: packer build mongodb-ami.pkr.hcl
# =============================================================================

packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# ---------------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------------
variable "aws_region" {
  description = "Región de AWS donde se creará la AMI"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia para el build"
  type        = string
  default     = "t2.micro"
}

variable "ami_name" {
  description = "Nombre de la AMI resultante"
  type        = string
  default     = "mongodb-ubuntu22-{{timestamp}}"
}

# ---------------------------------------------------------------------------
# Source: Amazon EBS (Ubuntu 22.04 LTS, HVM, x86_64)
# AMI base obtenida de: https://cloud-images.ubuntu.com/locator/ec2/
# ---------------------------------------------------------------------------
source "amazon-ebs" "ubuntu" {
  region        = var.aws_region
  instance_type = var.instance_type

  # Buscar automáticamente la AMI de Ubuntu 22.04 LTS más reciente
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] # Canonical
  }

  ssh_username = "ubuntu"

  ami_name        = var.ami_name
  ami_description = "AMI con MongoDB 7.x configurado como servicio. Generada con Packer."

  tags = {
    Name        = "mongodb-server"
    Environment = "production"
    Builder     = "Packer"
    OS          = "Ubuntu 22.04"
    Service     = "MongoDB"
  }

  associate_public_ip_address = true
}

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------
build {
  name    = "mongodb-aws"
  sources = ["source.amazon-ebs.ubuntu"]

  # Subir el script de provisioning
  provisioner "file" {
    source      = "scripts/setup-mongodb.sh"
    destination = "/tmp/setup-mongodb.sh"
  }

  # Ejecutar el script de provisioning
  provisioner "shell" {
    inline = [
      "chmod +x /tmp/setup-mongodb.sh",
      "sudo /tmp/setup-mongodb.sh"
    ]
  }

  # Post-processor: guarda el ID de la AMI generada en manifest.json
  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
