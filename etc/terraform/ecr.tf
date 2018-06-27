/* ECR定義 */

resource "aws_ecr_repository" "terraform" {
  name = "${var.name}"
}

resource "aws_ecr_repository_policy" "terraform" {
  repository = "${aws_ecr_repository.terraform.name}"
  policy = "${data.aws_iam_policy_document.terraform_ecr_repository_policy.json}"
}
data "aws_iam_policy_document" "terraform_ecr_repository_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "${aws_iam_role.terraform.arn}"
      ]
    }
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }
}
