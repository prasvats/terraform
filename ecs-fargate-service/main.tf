provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}

module "example_fronted" {
  source        = "./module/ecs-service-task"
  name          = "doc-fe"
  vpc_id        = var.vpc_id
  app_port      = 80
  cluster_id    = var.cluster_id
  vpc_subnets   = var.vpc_subnets
  lb_name       = "example-prod-shared-one-asp"
  listener_port = 443
  environment   = var.environment
  dns_name      = "staging.example.com"
  tags          = var.tags
  priority      = 1012
}

module "example_jw" {
  source               = "./module/ecs-service-task"
  name                 = "doc-jw"
  vpc_id               = var.vpc_id
  app_port             = 3000
  cpu                  = 256
  memory               = 512
  health_check_matcher = "404"
  cluster_id           = var.cluster_id
  vpc_subnets          = var.vpc_subnets
  lb_name              = "example-prod-shared-one-asp"
  listener_port        = 443
  dns_name             = "backend.staging.example.com"
  environment          = var.environment
  tags                 = var.tags
  priority             = 1022
}