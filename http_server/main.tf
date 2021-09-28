variable "instance_type" {}

resource "aws_instance" "default" {
  ami                    = "ami-0c3fd0f5d33134a76"
  vpc_security_group_ids = [aws_security_group.default.id]
  instance_type          = var.instance_type

  # tags = {
  #   "Name" = "example"
  # }

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}


resource "aws_security_group" "default" {
  name = "ec2"

  ingress = [
    {
      description      = "port 80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      self             = null
      security_groups  = null
    }
  ]

  egress = [
    {
      description      = "engres"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
}

output "example_public_dns" {
  value = aws_instance.default.public_dns
}
