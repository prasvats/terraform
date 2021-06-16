data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_kms_alias" "s3kmskey" {
  name = "alias/aws/s3"
}
resource "aws_codepipeline" "codepipeline" {
  name     = var.name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    # Using Default Pipeline
    # Need to Create Pipeline
    location = "codepipeline-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"
    # Provider https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference.html
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName       = var.name
        PollForSourceChanges = false
        BranchName           = "master"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"
      configuration = {
        ClusterName       = var.cluster_id
        ServiceName       = var.service_name
        FileName          = "imagedefinitions.json"
        DeploymentTimeout = 15
      }
    }
  }
}
