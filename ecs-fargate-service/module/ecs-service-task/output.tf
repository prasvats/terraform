output "target_group" {
  description = "Target Group ID for the Service"
  value       = aws_alb_target_group.create_tg.id
}

output "ecr_repo" {
  description = "ECR Repo Name"
  value       = aws_ecr_repository.ecr.name
}

output "log_group" {
  description = "Log Group Name"
  value       = aws_cloudwatch_log_group.logs_config.name
}

output "service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.ecs-service.name
}

output "task_defination" {
  description = "ECS task Defination"
  value       = aws_ecs_task_definition.task.family
}