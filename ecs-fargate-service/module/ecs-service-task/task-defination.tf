data "aws_ecs_task_definition" "task" {
  task_definition = aws_ecs_task_definition.task.family
}

data "aws_region" "current" {}
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
data "template_file" "container_json" {
  template = file("${path.module}/container-defination.tpl")
  vars = {
    region   = data.aws_region.current.name
    name     = var.name
    envname  = local.name
    image    = "${aws_ecr_repository.ecr.repository_url}:${var.image_tag}"
    app_port = var.app_port
    cpu      = var.cpu
    memory   = var.memory
  }
}
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
resource "aws_ecs_task_definition" "task" {
  family                   = local.name
  container_definitions    = data.template_file.container_json.rendered
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}
