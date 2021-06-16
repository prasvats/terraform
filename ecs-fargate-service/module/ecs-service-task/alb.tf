resource "aws_alb_target_group" "create_tg" {
  name                 = "${local.name}-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 90
  health_check {
    enabled = true
    path    = var.health_check_path
    matcher = var.health_check_matcher
  }
}

data "aws_lb" "shared_lb" {
  name = var.lb_name
}

data "aws_lb_listener" "listener" {
  load_balancer_arn = data.aws_lb.shared_lb.arn
  port              = var.listener_port
}
resource "aws_alb_listener_rule" "listner_rule" {
  listener_arn = data.aws_lb_listener.listener.arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.create_tg.arn
  }
  condition {
    host_header {
      values = ["${var.dns_name}"]
    }
  }
}
