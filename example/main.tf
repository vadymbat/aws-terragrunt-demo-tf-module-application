locals {
  lambda_artifact_s3_bucket = "terraform-20210417143745101900000001"
  service_name              = "announcements"
  resource_prefix           = "acc1-fastcar-use1-dev"
  rest_api_stage            = "dev"
  tags = {
    env          = "dev"
    project_name = "fastcar"
  }
}

module "announcement_app" {
  source                    = "../"
  aws_region                = "us-east-1"
  lambda_artifact_s3_bucket = local.lambda_artifact_s3_bucket
  service_name              = local.service_name
  resource_prefix           = local.resource_prefix
  rest_api_stage            = local.rest_api_stage
  tags                      = local.tags
}

output "api_endpoint" {
  value = module.announcement_app.api_url
}