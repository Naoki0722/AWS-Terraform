variable "name" {}
variable "policy" {}
variable "identifier" {}

# ポリシー
resource "aws_iam_policy" "default" {
  name   = var.name
  policy = var.policy
}

# ロール
resource "aws_iam_role" "default" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [var.identifier]
    }
  }
}

# ロールにポリシーをアタッチ
resource "aws_iam_policy_attachment" "default" {
  name       = "name-policy"
  roles      = [aws_iam_role.default.name]
  policy_arn = aws_iam_policy.default.arn

}

output "iam_role_arn" {
  value = aws_iam_role.default.arn
}

output "iam_role_name" {
  value = aws_iam_role.default.name
}
