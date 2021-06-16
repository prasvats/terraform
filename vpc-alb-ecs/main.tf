locals {
  environment = var.environment
  name        = "${var.name}-${var.environment}"
  region      = var.region
  tags        = var.tags
}

provider "aws" {
  region = local.region
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.0.0"
  name            = local.name
  cidr            = var.vpc_cidr
  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = var.private_cidrs
  public_subnets  = var.public_cidrs
  enable_ipv6     = true

  # Single NAT Gateway
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # public_subnet_tags = {
  #   Name = "overridden-name-public"
  # }
  tags = local.tags
}

resource "random_pet" "this" {
  length = 2
}

module "shared_alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "alb-sg-${random_pet.this.id}"
  description = "Security group for shared ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
}

module "shared_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.1.0"

  name = "${local.name}-shared-${random_pet.this.id}"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  security_groups = [module.shared_alb_security_group.security_group_id]
  subnets         = module.vpc.public_subnets

  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined

    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
  ]
}

################################################################################
# ECS Cluster 
################################################################################
resource "aws_ecs_cluster" "cluster" {
  name               = local.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = local.tags
} 