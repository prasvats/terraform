################################################################################
# Global Varibale
################################################################################
variable "region" {
  description = "AWS Region in which you are working"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "vpc_subnets" {
  description = "VPC Subnets"
}

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

variable "listener_port" {
  description = "Listener Port"
  default     = 80
}


variable "cluster_id" {
  description = "Cluster Id"
}
