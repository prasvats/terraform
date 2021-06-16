output "s3_bucket_name" {
  description = "Name of the S3 Bucket"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table" {
  description = "Name of the DynamoDB Table"
  value       = aws_dynamodb_table.terraform_state_lock.name
}