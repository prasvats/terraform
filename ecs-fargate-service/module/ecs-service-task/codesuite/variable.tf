variable "name" {
  description = "Name of the application"
}

variable "ecr_repository_uri" {
  description = "Repository URI"
}
################################################################################
# VPC 
################################################################################
variable "vpc_id" {
  description = "VPC ID"
}

variable "vpc_subnets" {
  description = "VPC Subnets"
}

################################################################################
# ECS 
################################################################################

variable "cluster_id" {
  description = "Cluster Name"
}

variable "service_name" {
  description = "Service Name"
}

variable "compute_type" {
  description = "Code Build Comute Type"
  default     = "BUILD_GENERAL1_SMALL"
}
