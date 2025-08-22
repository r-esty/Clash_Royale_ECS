locals {
  project_name = "clash-royale-deck"
 
}

module "vpc" {
  source = "./modules/vpc"
  
  project_name = local.project_name
  vpc_cidr     = var.vpc_cidr
}

module "ecr" { 
  source = "./modules/ecr"
  
  project_name = local.project_name
}

resource "aws_secretsmanager_secret" "api_key" {
  name = "${local.project_name}-api-key-v2"
  recovery_window_in_days = 0 
}

resource "aws_secretsmanager_secret_version" "api_key" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = var.clash_royale_api_key
}

module "iam" {
  source = "./modules/iam"
  
  project_name = local.project_name
  secret_arn   = aws_secretsmanager_secret.api_key.arn
}

module "alb" {
  source = "./modules/alb"
  
  project_name          = local.project_name
  certificate_arn       = var.certificate_arn
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.vpc.alb_security_group_id
}

module "ecs" {
  source = "./modules/ecs"
  
  project_name          = local.project_name
  aws_region            = var.aws_region
  
  secret_arn            = aws_secretsmanager_secret.api_key.arn
  ecr_repository_url    = module.ecr.repository_url
  ecs_security_group_id = module.vpc.ecs_security_group_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  target_group_arn      = module.alb.target_group_arn
  execution_role_arn    = module.iam.execution_role_arn
  task_role_arn         = module.iam.task_role_arn  
}

data "aws_route53_zone" "main" {
  name = var.domain_name
}


module "route53" {
  source = "./modules/route53"

  
  
  zone_id      = data.aws_route53_zone.main.zone_id
  domain_name  = "tm.${var.domain_name}"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}
