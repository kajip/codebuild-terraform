/* 変数定義 */

variable "region" {
  description = "リージョン"
  default = "ap-northeast-1"
}

variable "name" {
  description = "プロジェクト名"
}
variable "description" {
  description = "プロジェクト概要"
}

variable "github_location" {
  description = "GitHubレポジトリのロケーション"
  default = "https://github.com/tkajita/codebuild-terraform.git"
}
