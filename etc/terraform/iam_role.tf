/* IAMロール定義 */

resource "aws_iam_role" "terraform" {
  name = "${var.name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "terraform" {
  role = "${aws_iam_role.terraform.id}"
  policy = "${data.aws_iam_policy_document.role_policy.json}"
}
data "aws_iam_policy_document" "role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "ssm:GetParameters"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}
