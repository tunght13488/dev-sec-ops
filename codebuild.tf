resource "aws_codebuild_project" "codebuild_project" {
  name          = "eks_codebuuld"
  description   = "eks devsecops codebuild project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/password-manager:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codepipeline_bucket.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/xxxx/dev-sec-ops-eks.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

  vpc_config {
    vpc_id = aws_vpc.eks_vpc.id

    subnets = [
      aws_subnet.eks_subnet1.id,
      aws_subnet.eks_subnet2.id,
      aws_subnet.eks_subnet3.id,
    ]

    security_group_ids = [
      aws_security_group.eks_sg.id,
    ]
  }

  tags = {
    Environment = "Test"
  }
}
