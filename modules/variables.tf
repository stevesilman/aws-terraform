# General Variables

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "eu-west-1"
}

variable "app_name" {
  description = "Name of the web application"
  type        = string
  default     = "web-app-ssilman"
}

variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = "dev"
}

# EC2 Variables

variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-0333305f9719618c7" # Ubuntu 20.04 LTS // eu-west-1
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

