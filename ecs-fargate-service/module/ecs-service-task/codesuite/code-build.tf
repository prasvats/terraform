data "template_file" "buildspec" {
  template = file("${path.module}/buildspec.tpl")
  vars = {
    ecr_repository_uri = var.ecr_repository_uri
    container_name     = var.name
  }
}

resource "aws_codebuild_project" "codebuild" {
  name          = var.name
  description   = var.name
  build_timeout = 30
  service_role  = aws_iam_role.codebuild.arn
  badge_enabled = true

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = var.compute_type
    image                       = "aws/codebuild/standard:5.0-21.04.23"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = aws_cloudwatch_log_group.codebuild_log.name
    }

    s3_logs {
      status   = "ENABLED"
      location = "codepipeline-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}/build-log"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.repo.clone_url_http
    buildspec       = data.template_file.buildspec.rendered
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.vpc_subnets
    security_group_ids = ["${module.service_security_group.security_group_id}"]
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

  name        = "${var.name}-${random_pet.this.id}"
  description = "Security group for CodeBuild ${var.name}"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["${data.aws_vpc.vpc_info.cidr_block}"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}
