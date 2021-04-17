terraform {
  backend "s3" {}
}

resource "aws_api_gateway_rest_api" "apigateway_announcement_app" {
  name = "${var.resource_prefix}-apigw-announcement-api"
  body = templatefile("${path.module}/templates/swagger.yaml", local.lambda_integration_uris)
  tags = merge(var.default_tags, var.tags)
}

resource "aws_api_gateway_deployment" "apigateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigateway_announcement_app.id
  stage_name  = var.rest_api_stage
  variables = {
    apispec_hash = filesha1("${path.module}/templates/swagger.yaml")
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_dynamodb_table" "announcements" {
  #checkov:skip=CKV_AWS_125: "Ensure that that point in time recovery is enabled for Amazon DynamoDB tables"
  #checkov:skip=CKV_AWS_119: "Ensure DynamoDB Tables are encrypted using KMS"
  #checkov:skip=CKV_AWS_28: "Ensure Dynamodb point in time recovery (backup) is enabled"
  name           = "${var.resource_prefix}-db-${var.dynamodb_announcements_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
  tags = merge(var.default_tags, var.tags)
}
