

data "aws_secretsmanager_secret" "secrets" {
  name = "MY_MAC_SSH_PUB"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

output "secrets" {
  value = jsondecode(aws_secretsmanager_secret_version.current.secret_string)["MY_MAC_SSH_PUB_KEY"]
}

resource "aws_instance" "ec2-instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2-instances.name]
  user_data       = <<-EOF
                    #!/bin/bash
                    sudo -u ubuntu bash -c 'echo "${data.aws_secretsmanager_secret_version.current.secret_string}" >> ~/.ssh/authorized_keys'
                 EOF
}

