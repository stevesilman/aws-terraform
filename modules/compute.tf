data "local_file" "public_ssh_key" {
  filename = "/Users/ssilman/.ssh/id_rsa.pub"
}

resource "aws_instance" "ec2-instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2-instances.name]
  user_data       = <<-EOF
                    #!/bin/bash
                    sudo -u ubuntu bash -c 'echo "${data.local_file.public_ssh_key.content}" >> ~/.ssh/authorized_keys'
                    sudo -u ubuntu bash -c 'echo wanker-ssilman > /tmp/wanker.txt'
              EOF
}

