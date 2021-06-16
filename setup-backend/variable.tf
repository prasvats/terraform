variable "tf_state_bucket" {
  description = "S3 Bucket for TF State"
}

variable "region" {
  description = "AWS Region"
}

variable "dynamodb_table" {
  description = "Name of DynamoDB Table"
  default     = "terraform-app-state"
}