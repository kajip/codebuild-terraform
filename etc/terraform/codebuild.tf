/* CodeBuild定義 */

resource "aws_codebuild_project" "terraform" {
  name = "${var.name}"
  description = "${var.description}"
  service_role = "${aws_iam_role.terraform.arn}"

  "environment" {
    compute_type = "BUILD_GENERAL1_SMALL"
    type = "LINUX_CONTAINER"
    image = "aws/codebuild/docker:1.12.1"
    privileged_mode = true

    environment_variable {
      name = "AWS_DEFAULT_REGION"
      value = "${var.region}"
    }
    environment_variable {
      name = "ECR_REPOSITORY_URL"
      value = "${aws_ecr_repository.terraform.repository_url}"
    }
    environment_variable {
      name = "IMAGE_TAG"
      value = "latest"
    }
  }

  "source" {
    type = "GITHUB"
    location = "${var.github_location}"
    git_clone_depth = 1
  }

  "artifacts" {
    type = "NO_ARTIFACTS"
  }
}

resource "aws_codebuild_webhook" "terraform" {
  project_name = "${aws_codebuild_project.terraform.name}"
  branch_filter = "master"
}
