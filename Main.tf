# Módulo de red: VPC, subnets, Internet Gateway, NAT Gateway y Security Groups
module "mi_red" {
  source        = "./modules/network"
  mi_ip_publica = var.mi_ip_publica
  region        = var.region
}

# Módulo de cómputo: instancia de App (Nginx + Node.js) e instancia MongoDB
module "mi_computo" {
  source            = "./modules/compute"
  ami_id_app        = var.ami_id_app
  ami_id_mongodb    = var.ami_id_mongodb
  sg_app_id         = module.mi_red.security_group_id
  sg_mongodb_id     = module.mi_red.sg_mongodb_id
  public_subnet_id  = module.mi_red.public_subnet_1_id
  private_subnet_id = module.mi_red.private_subnet_id
  key_name          = var.key_name
}

# Módulo de balanceo de carga: Application Load Balancer
module "mi_balanceador" {
  source             = "./modules/loadbalancer"
  sg_alb_id          = module.mi_red.sg_alb_id
  public_subnet_1_id = module.mi_red.public_subnet_1_id
  public_subnet_2_id = module.mi_red.public_subnet_2_id
  vpc_id             = module.mi_red.vpc_id
  app_instance_id    = module.mi_computo.app_instance_id
}
