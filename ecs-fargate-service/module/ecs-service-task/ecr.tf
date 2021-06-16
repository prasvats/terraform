resource "aws_ecr_repository" "ecr" {
  name                 = local.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}