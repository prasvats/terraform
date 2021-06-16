resource "aws_cloudwatch_log_group" "logs_config" {
  name              = local.name
  retention_in_days = var.logs_retention_days
}
