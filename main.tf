provider "aws" {
  profile = var.aws_profile
  region  = "ap-northeast-1"
}

variable "aws_profile" {}

resource "aws_iam_role" "oidc" {
  name               = "gh-oidc-sample-github-actions"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy" "oidc" {
  name   = "gh-oidc-sample-github-actions"
  role   = aws_iam_role.oidc.id
  policy = data.aws_iam_policy_document.sample.json
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:tmtk75/gh-oidc-sample:*"]
    }
  }
}

data "aws_iam_policy_document" "sample" {
  statement {
    actions = [
      "sts:GetCallerIdentity",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "https://github.com/tmtk75",
  ]
  thumbprint_list = ["a031c46782e6e6c662c2c87c76da9aa62ccabd8e"]
}
