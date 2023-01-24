

data "aws_secretsmanager_secret" "secrets" {
  name = "MY_MAC_SSH_PUB"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

output "sensitive_ssh_hash" {
  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))
}

resource "aws_instance" "ec2-instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2-instances.name]
  user_data       = <<-EOF
                    #!/bin/bash
                    sudo -u ubuntu bash -c 'echo "${data.aws_secretsmanager_secret_version.current.secret_string}" >> ~/.ssh/authorized_keys'
                    sudo -u ubuntu bash -c 'echo wanker-ssilman  > /tmp/wanker.txt'
              EOF
}

