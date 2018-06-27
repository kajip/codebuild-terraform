# CodeBuild用Terraform Dockerイメージ

CodeBuildを使って、Terraformを実行するためのイメージ。

## 構成

* Dockerfile

    Dockerイメージを構築するための設定ファイル

* [etc/terraform](etc/terraform)

    このイメージを生成するために必要な環境をAWS上に構築するためのTerraformファイル置き場

## 事前準備

1. Terraformのインストール

2. AWS CLI のインストール

    pip(pythonのライブラリ管理ツール)を利用してインストールします。
    
    ```bash
    % pip install awscli
    ```

3. AWSの設定

    ホームディレクトリに .awsディレクトリを作成し、そこに config という名前のファイルを作成します。
    
    ```
    [default]
    region = ap-northeast-1
    output = json
    ```

    AWS側でアクセストークンを発行し、ホームディレクトリの.aws/credentials
    
    ```
    [default]
    aws_access_key_id = <<AWSで発行したアクセスキー>>
    aws_secret_access_key = <<AWSで発行したシークレットキー>>
    ```

## 初期構築

1. Terraformを実行

    etc/terraformディレクトリ直下で下記コマンドを実行する

    ```bash
    % terraform apply
    ```

2. CodeBuildを実行

    CodeBuildを実行し、Dockerイメージを生成する

    ```bash
    % aws codebuild start-build --project-name codebuild-terraform
    ```

## 環境の削除

1. 破棄

    Terraformを使って環境を削除する
    
    ```bash
    % terraform destroy
    ```