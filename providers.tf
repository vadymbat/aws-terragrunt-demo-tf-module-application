provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile != "" ? var.aws_profile : null
  assume_role {
    role_arn = var.aws_provider_role != "" ? var.aws_provider_role : null
  }
}