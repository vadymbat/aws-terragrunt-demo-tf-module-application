data "archive_file" "lambda_package" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/${var.service_name}.zip"
}

resource "aws_s3_bucket_object" "lambda_artifact" {
  bucket = var.lambda_artifact_s3_bucket
  key    = "artifacts/${var.service_name}.zip"
  source = "${path.module}/${var.service_name}.zip"

  etag = data.archive_file.lambda_package.output_md5
}

module "aws_lambda_create_announcement" {
  source = "./modules/aws_lambda"

  # iam configuration
  role_name            = "CreateAnnouncementLambdaRole"
  aws_region           = var.aws_region
  sam_policies         = ["DynamoDBCrudPolicy"]
  dynamodb_table_names = [aws_dynamodb_table.announcements.id]

  # lambda configuration
  lambda_name             = "${var.resource_prefix}-lambda-create-announcement"
  lambda_artifacts_bucket = var.lambda_artifact_s3_bucket
  lambda_artifacts_key    = aws_s3_bucket_object.lambda_artifact.id
  lambda_runtime          = "python3.7"
  lambda_handler          = "handler.create_announcement"
  lambda_env_variables = {
    "ANNOUNCEMENT_TABLE_NAME" = aws_dynamodb_table.announcements.id
    "LOG_LEVEL"               = var.lambda_log_level
  }
  tags = merge(var.default_tags, var.tags)
}

module "aws_lambda_list_announcements" {
  source = "./modules/aws_lambda"

  # iam configuration
  role_name            = "${var.resource_prefix}-role-ListAnnouncementsLambdaRole"
  aws_region           = var.aws_region
  sam_policies         = ["DynamoDBCrudPolicy"]
  dynamodb_table_names = [aws_dynamodb_table.announcements.id]

  # lambda configuration
  lambda_name             = "${var.resource_prefix}-list-announcements"
  lambda_artifacts_bucket = var.lambda_artifact_s3_bucket
  lambda_artifacts_key    = aws_s3_bucket_object.lambda_artifact.id
  lambda_runtime          = "python3.7"
  lambda_handler          = "handler.list_announcements"
  lambda_env_variables = {
    "ANNOUNCEMENT_TABLE_NAME" = aws_dynamodb_table.announcements.id
    "LOG_LEVEL"               = var.lambda_log_level
  }
  tags = merge(var.default_tags, var.tags)
}

resource "aws_lambda_permission" "lambda_create_announcement" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.aws_lambda_create_announcement.function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.apigateway_announcement_app.execution_arn}/*/POST/*"
}

resource "aws_lambda_permission" "lambda_list_announcements" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.aws_lambda_list_announcements.function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.apigateway_announcement_app.execution_arn}/*/GET/*"
}