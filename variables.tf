variable "aws_region" {
}

variable "resource_prefix" {
  description = "Prefix for aws resources"
}

variable "rest_api_stage" {
  type        = string
  description = "Api gateway stage name"
}

variable "lambda_artifact_s3_bucket" {
  type        = string
  description = "The s3 bucket for artifacts"
}

variable "service_name" {
  type        = string
  description = "Application name wich will added to resources names"
}