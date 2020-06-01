module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.10.0"
  namespace  = var.namespace
  stage      = var.env
  name       = "vpc"
  cidr_block = var.vpc_cidr_block
}

module "dynamic_subnets" {
  source             = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.19.0"
  namespace          = var.namespace
  stage              = var.env
  name               = "subnet"
  availability_zones = ["eu-central-1a","eu-central-1b"]
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  cidr_block         = var.vpc_cidr_block
}

module "broker" {
  source                     = "./modules/broker"
  namespace                  = var.namespace
  stage                      = var.env
  name                       = "broker"
  apply_immediately          = "false"
  auto_minor_version_upgrade = "true"
  engine_version             = "5.15.6"
  mq_admin_user              = var.broker_root_user
  mq_admin_password          = var.broker_root_password
  mq_application_user        = var.app_name
  mq_application_password    = var.broker_application_password
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.dynamic_subnets.private_subnet_ids
  security_groups            = [module.vpc.vpc_default_security_group_id]
}
