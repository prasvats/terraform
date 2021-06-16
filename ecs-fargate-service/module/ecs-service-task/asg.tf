resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_id}/${aws_ecs_service.ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "asg_policy" {
  name        = "${local.name}-target-alb-request-count"
  policy_type = "TargetTrackingScaling"

  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 500
    scale_in_cooldown  = 240
    scale_out_cooldown = 60

    # ... potentially other configuration ...
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${data.aws_lb.shared_lb.arn_suffix}/${aws_alb_target_group.create_tg.arn_suffix}"
    }
  }
}