resource "aws_ecs_service" "ecs-service" {
  name                               = local.name
  cluster                            = var.cluster_id
  desired_count                      = var.desire_count
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = 100
  task_definition                    = "${aws_ecs_task_definition.task.family}:${max("${aws_ecs_task_definition.task.revision}", "${data.aws_ecs_task_definition.task.revision}")}"
  load_balancer {
    target_group_arn = aws_alb_target_group.create_tg.arn
    container_port   = var.app_port
    container_name   = var.name
  }
  network_configuration {
    assign_public_ip = false
    subnets          = var.vpc_subnets
    security_groups  = ["${module.service_security_group.security_group_id}"]
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "random_pet" "this" {
  length = 2
}

data "aws_vpc" "vpc_info" {
  id = var.vpc_id
}


module "service_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.2.0"

  name        = "${local.name}-${random_pet.this.id}"
  description = "Security group for ${local.name}"
  vpc_id      = var.vpc_id

  # ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port   = var.app_port
      to_port     = var.app_port
      protocol    = "tcp"
      description = "Service Ports"
      cidr_blocks = data.aws_vpc.vpc_info.cidr_block
    }
  ]
}
