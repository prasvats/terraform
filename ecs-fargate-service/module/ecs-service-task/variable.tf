################################################################################
# Global Varibale
################################################################################
variable "environment" {
  description = "Environment"
}

variable "tags" {
  description = "Tags for the Infrastructure"
  default = {
    Owner       = "prashant"
    Environment = "dev"
  }
}

################################################################################
# VPC and ALB
################################################################################
variable "vpc_id" {
  description = "VPC ID"
}

variable "vpc_subnets" {
  description = "VPC Subnets"
}

variable "lb_name" {
  description = "Load Balancer Name"
}

variable "listener_port" {
  description = "Listener Port"
  default     = 443
}

variable "priority" {
  description = "Priority for Rule"
}

variable "dns_name" {
  description = "DNS Name for application"
  default     = "example.com"
}

variable "health_check_matcher" {
  description = "Health check Matcher"
  default     = "200"
}

variable "health_check_path" {
  description = "Health Check Path"
  default     = "/"
}
################################################################################
# Logs and ECR
################################################################################

variable "logs_retention_days" {
  description = "Cloudwatch Logs Retention Days"
  default     = 7
}

variable "scan_on_push" {
  description = "Scan on Push"
  default     = false
}

variable "cluster_id" {
  description = "Cluster Id"
}

variable "desire_count" {
  description = "Desire Count"
  default     = 1
}

variable "min_capacity" {
  description = "Minimum Capacity of ECS Service"
  default     = 1
}

variable "max_capacity" {
  description = "Maximum Capacity of ECS Service"
  default     = 5
}

################################################################################
# App Variable
################################################################################
variable "name" {
  description = "Identifier for the application"
}

variable "app_port" {
  description = "Application Port"
}

# CPU and Memory Constraint Fargate
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
variable "cpu" {
  description = "CPU"
  default     = 256
}

variable "memory" {
  description = "Memory"
  default     = 512
}

variable "image_tag" {
  description = "Image tag"
  default     = "latest"
}
