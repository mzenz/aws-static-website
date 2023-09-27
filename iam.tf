# GitHub Actions IAM policy
data "aws_iam_policy_document" "github_actions_iam_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_oidc_provider.arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/*:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# GitHub Actions IAM role
resource "aws_iam_role" "github_actions_iam_role" {
  name               = "GitHubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.github_actions_iam_policy.json
}

# GitHub OpenID Connect provider
resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  url = var.aws_openid_connect_url

  client_id_list = ["sts.amazonaws.com"]

  # Required but not used by IAM, just set to all F's
  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}

