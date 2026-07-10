# Llamamos al módulo de red para que cree la seguridad
module "mi_red" {
  source        = "./modules/network"
  mi_ip_publica = var.mi_ip_publica
}

# Llamamos al módulo de cómputo para que cree la máquina virtual
module "mi_computo" {
  source         = "./modules/compute"
  ami_id         = var.mi_ami_id
  grupo_seguridad_id = module.mi_red.security_group_id # Toma el ID que generó el módulo de red
}
