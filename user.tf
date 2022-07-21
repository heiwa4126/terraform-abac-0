data "local_file" "my_pgp_pub_key" {
  filename = "./pgp/my-public-key.gpg"
}

resource "aws_iam_user" "user1" {
  name = "${var.prefix}user1-${random_id.id.hex}"
  path = "/example/"
  tags = {
    project-name = "falcon"
  }
}

resource "aws_iam_user_policy" "user1" {
  user   = aws_iam_user.user1.name
  policy = data.aws_iam_policy_document.user.json
}

resource "aws_iam_access_key" "user1" {
  user    = aws_iam_user.user1.name
  pgp_key = data.local_file.my_pgp_pub_key.content_base64
}

resource "aws_iam_user" "user2" {
  name = "${var.prefix}user2-${random_id.id.hex}"
  path = "/example/"
  tags = {
    project-name = "eagle"
  }
}

resource "aws_iam_user_policy" "user2" {
  user   = aws_iam_user.user2.name
  policy = data.aws_iam_policy_document.user.json
}

resource "aws_iam_access_key" "user2" {
  user    = aws_iam_user.user2.name
  pgp_key = data.local_file.my_pgp_pub_key.content_base64
}

data "aws_iam_policy_document" "user" {
  statement {
    # 関数の一覧表示と、Lambda固有情報の取得はできるようにする
    sid    = "AllResourcesLambdaNoTags"
    effect = "Allow"
    actions = [
      "lambda:ListFunctions",
      "lambda:GetAccountSettings"
    ]
    resources = ["*"]
  }
  statement {
    # Lambdaの実行更新にかかわる全ては、project-nameタグが一致したらOKとする
    sid    = "AllActionsLambdaSameProject"
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction",
      "lambda:UpdateFunctionConfiguration",
      "lambda:CreateAlias",
      "lambda:DeleteAlias",
      "lambda:DeleteFunction",
      "lambda:DeleteFunctionConcurrency",
      "lambda:GetAlias",
      "lambda:GetFunction",
      "lambda:GetFunctionConfiguration",
      "lambda:GetPolicy",
      "lambda:ListAliases",
      "lambda:ListVersionsByFunction",
      "lambda:PublishVersion",
      "lambda:PutFunctionConcurrency",
      "lambda:UpdateAlias",
      "lambda:UpdateFunctionCode"
    ]
    resources = ["arn:aws:lambda:*:*:function:*"]
    # resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/project-name"
      values = [
        "&{aws:PrincipalTag/project-name}"
      ]
    }
  }
}

#----
output "user1_id" {
  value = aws_iam_access_key.user1.id
}
output "user1_secret" {
  value = aws_iam_access_key.user1.encrypted_secret
}
output "user2_id" {
  value = aws_iam_access_key.user2.id
}
output "user2_secret" {
  value = aws_iam_access_key.user2.encrypted_secret
}
