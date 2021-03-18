resource "aws_codepipeline" "codepipeline" {
  name     = "eks-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.eks_cs.arn
        FullRepositoryId = "dev-sec-ops-eks"
        BranchName       = "master"
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
        ProjectName = "devsecops"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "devsecops"
        TemplatePath   = "build_output::deployment.yaml"
      }
    }
  }
}

resource "aws_codestarconnections_connection" "eks_cs" {
  name          = "codestar"
  provider_type = "GitHub"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "devsecops-eks"
  acl    = "private"
}

data "aws_kms_alias" "s3kmskey" {
  name = "alias/myKmsKey"
}
