provider "aws" {
  region  = var.region
}

resource "aws_s3_bucket" "b_example" {
  bucket = "bucket-example-tmed232323"
  force_destroy = true
  acl    = "private"

  versioning {
    enabled = true
  }
}

terraform {
  backend "s3" {
    bucket = "bucket-example-tmed232323"
    key    = "terraform-aws-automation/create-s3-backend-state/terraform.tfstate"
  }
}