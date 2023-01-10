terraform {
  backend "s3" {
    bucket         = "ssilman-directive-tf-state"
    key            = "ssilman-ec2-instance/terraform.tfstate"
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

# This adopts the deault VPC and renames it to Deafault VPC
# Note aws ec2 create-default-vpc creates it if it doesn't exist

resource "aws_default_vpc" "default" {
    tags = {
        Name = "Default VPC"
    }
}

# Next add IGW to allow access so we can get through to the EC2

