provider "aws" {
  region  = var.region
  profile = "Blitline2-dev"
}


provider "aws" {
  alias   = "ops-prod"
  region  = var.region
  profile = "ops"
}

terraform {
  backend "s3" {

  }
}


data "aws_ssm_parameter" "ecsami" {
  provider = aws.ops-prod
  name     = "/ops/ami/recommended/ecs"
}

data "aws_ssm_parameter" "secrets" {
  provider = aws.ops-prod
  name     = "/ops/tf/Blitline2-dev-secrets"
}

data "aws_caller_identity" "current" {}



