provider "aws" {
    region                  = "us-west-2"
    profile                 = "Blitline2-dev" 
}

resource "aws_s3_bucket" "Blitline2-dev-tf-s3-backend-state1111" {
  bucket = "blitline2-dev-tf-s3-backend-state1111"
  acl    = "private"

  tags = {
    Name        = "blitline2-dev-tf-s3-backend-state1111"
    Environment = "dev"
  }
}