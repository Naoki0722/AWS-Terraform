variable "name" {}
variable "vpc_id" {}
variable "port" {}
variable "cidr_blocks" {
  type = list(string)
}

# セキュリティーグループ
resource "aws_security_group" "default" {
  name   = var.name
  vpc_id = var.vpc_id
}

# インバウンド(in側)
# HTTPで通信できるようport80を開ける
resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.default.id
}


# アウトバウンド(out側)
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.default.id
}

output "security_group_id" {
  value = aws_security_group.default.id
}