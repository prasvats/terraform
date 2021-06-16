resource "aws_cloudwatch_log_group" "codebuild_log" {
  name              = "${var.name}-codebuild"
  retention_in_days = 7
}