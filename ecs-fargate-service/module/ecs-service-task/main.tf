terraform {
  required_version = ">= 0.14.7"
}
locals {
  environment = var.environment
  name        = "${var.name}-${var.environment}"
  tags        = var.tags
}

module "name" {
  source             = "./codesuite"
  name               = var.name
  vpc_id             = var.vpc_id
  vpc_subnets        = var.vpc_subnets
  ecr_repository_uri = aws_ecr_repository.ecr.repository_url
  cluster_id         = var.cluster_id
  service_name       = aws_ecs_service.ecs-service.name
}