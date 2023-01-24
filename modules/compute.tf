

data "aws_secretsmanager_secret" "public_ssh_key_from_aws" {
  name = "MY_MAC_SSH_PUB"
}

resource "aws_instance" "ec2-instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2-instances.name]
  user_data       = <<-EOF
                    #!/bin/bash
                    sudo -u ubuntu bash -c 'echo "${data.aws_secretsmanager_secret.public_ssh_key_from_aws.content}" >> ~/.ssh/authorized_keys'
                    sudo -u ubuntu bash -c 'echo wanker-ssilman  > /tmp/wanker.txt'
              EOF
}

