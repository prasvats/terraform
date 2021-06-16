resource "aws_codecommit_repository" "repo" {
  repository_name = var.name
  description     = var.name
  default_branch  = "master"
}

