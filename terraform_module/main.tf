module "vpc" {
  source = "modules/vpc"

  namespace           = var.namespace
  azs                 = var.azs
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  web_subnet_cidrs    = var.web_subnet_cidrs
  app_subnet_cidr     = var.app_subnet_cidrs
  db_subnet_cidr      = var.db_subnet_cidrs
  vpc_peer            = var.vpc_peer
}

module "ec2" {
  source = "modules/ec2"

  namespace     = var.namespace
  ami_id        = var.ami_id
  instance_type = var.instance_type
  #key_name      = var.key_name
  subnet_id = module.vpc.public_subnet_name
  sg_name   = module.security_group.allow_http_sg_id
  key_name  = module.ssh_key.key_name
}

module "security_group" {
  source = "modules/security_groups"

  vpc_id    = module.vpc.vpc_id
  namespace = var.namespace
}

module "ssh_key" {
  source = "modules/ssh-key"

  region    = var.region
  namespace = var.namespace
}