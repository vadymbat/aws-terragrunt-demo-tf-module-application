locals {
  lambda_integration_uris = {
    lambda_integration_uri_create_announcement = module.aws_lambda_create_announcement.function_api_integration_uri,
    lambda_integration_uri_list_announcements  = module.aws_lambda_list_announcements.function_api_integration_uri
  }
  tags = merge(var.default_tags, var.tags)
}