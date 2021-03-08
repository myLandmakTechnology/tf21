/*
#customize this to change state store name in S3 bucket
terraform {
  backend "s3" {
    key = "aws-wbts-marsBlitline2-dev/Blitline2/dev/ecs/terraform.tfstate"
    profile = "Blitline2-dev" 
    region         = "us-west-2"
    bucket         = "blitline2-dev-tf-s3-backend-state1111"
    dynamodb_table = "blitline2-dev-tf-dynamodb-backend-state-lock1111"
    encrypt        = true
  }
}
*/