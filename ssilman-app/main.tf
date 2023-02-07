terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See github/ssilman/terraform/aws-terraform/aws-backend
  backend "s3" {
    bucket         = "ssilman-directive-tf-state"
    key            = "web-app-ssilman/terraform.tfstate"
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


module "web_app_ssilman1" {
  source = "../modules"

  # Input Variables
  app_name         = "web-app-ssilman-1"
  environment_name = "dev"
  instance_type    = "t2.micro"
}

