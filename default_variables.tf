variable "default_tags" {
  type = map(string)
  default = {
    module = "aws-terragrunt-demo-tf-module-application"
    "ManagedBy" = "terraform"
  }
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "aws_profile" {
  type    = string
  default = ""
}

variable "aws_provider_role" {
  type    = string
  default = ""
}

variable "lambda_log_level" {
  type    = string
  default = "DEBUG"
}

variable "dynamodb_announcements_table_name" {
  type    = string
  default = "announcements-table"
}
