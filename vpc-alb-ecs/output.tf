################################################################################
# VPC Module
################################################################################

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

################################################################################
# ALB Module
################################################################################

# Load Balancer
output "lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.shared_alb.lb_id
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.shared_alb.lb_arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.shared_alb.lb_dns_name
}

################################################################################
# ECS Cluster 
################################################################################

output "ecs_cluster" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.cluster.name
}

output "ecs_cluster_arn" {
  description = "ECS Cluster ARN"
  value       = aws_ecs_cluster.cluster.arn
}