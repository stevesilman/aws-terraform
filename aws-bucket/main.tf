terraform {
  backend "s3" {
    bucket         = "ssilman-directive-tf-state"
    key            = "ssilman-s3-bucket/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
resource "aws_s3_bucket" "bucket" {
  bucket        = "ssilman-s3-data-bucket"
  force_destroy = true
}

