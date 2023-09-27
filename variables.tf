variable "company_domain_name" {
  default = "groovly.net"
}

variable "company_name" {
  default = "groovly"
}

variable "profile" {}

variable "stage" {}

variable "region" {}

variable "github_org" {
  description = "GitHub organization name where repositories are hosted"
}

variable "aws_openid_connect_url" {
  default = "https://token.actions.githubusercontent.com"
}
