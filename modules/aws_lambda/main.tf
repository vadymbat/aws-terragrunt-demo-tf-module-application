terraform {
  required_version = ">=0.12.29"
}

module "lambda_role" {
  source               = "../aws_lambda_role"
  sam_policies         = var.sam_policies
  custom_policies      = var.custom_policies
  role_name            = var.role_name
  dynamodb_table_names = var.dynamodb_table_names
  aws_region           = var.aws_region
}

resource "aws_lambda_function" "lambda_function" {
  #checkov:skip=CKV_AWS_117: "Ensure that AWS Lambda function is configured inside a VPC"
  #checkov:skip=CKV_AWS_115: "Ensure that AWS Lambda function is configured for function-level concurrent execution limit"
  #checkov:skip=CKV_AWS_50: "X-ray tracing is enabled for Lambda"
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  function_name = var.lambda_name
  role          = module.lambda_role.arn
  handler       = var.lambda_handler
  s3_bucket     = var.lambda_artifacts_bucket
  s3_key        = var.lambda_artifacts_key
  # source_code_hash = filebase64sha256("lambda_function_payload.zip")
  runtime = var.lambda_runtime

  environment {
    variables = var.lambda_env_variables
  }

  tags = var.tags
}
