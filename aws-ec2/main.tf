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

data "local_file" "public_ssh_key" {
  filename = "/Users/ssilman/.ssh/id_rsa.pub"
}

resource "aws_instance" "ssilman-ec2-ubuntu" {
  ami             = "ami-026e72e4e468afa7b" # Ubuntu 22.04 LTS // eu-west-1
  instance_type   = "t2.micro"
  user_data       = <<-EOF
              #!/bin/bash
              sudo -u ubuntu bash -c 'echo "${data.local_file.public_ssh_key.content}" >> ~/.ssh/authorized_keys'
              EOF
}

