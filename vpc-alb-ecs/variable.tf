################################################################################
# Global Varibale
################################################################################
variable "region" {
  description = "AWS Region in which you are working"
}

variable "name" {
  description = "Identifier for the application"
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

################################################################################
# VPC Varibale
################################################################################
variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}
variable "public_cidrs" {
  description = "Public Subnet cidr block. Example: 10.0.1.0/24 at least 3"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_cidrs" {
  description = "Public Subnet cidr block. Example: 10.0.3.0/24 at least 3"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}