# aws-terragrunt-demo-tf-module-application

[![Build Status](https://app.travis-ci.com/vadymbat/aws-terragrunt-demo-tf-module-application.svg?branch=main)](https://app.travis-ci.com/github/vadymbat/aws-terragrunt-demo-tf-module-application)

More details about the application is available by the [link](https://github.com/vadymbat/aws-serverless-announcement-microservice).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_lambda_create_announcement"></a> [aws\_lambda\_create\_announcement](#module\_aws\_lambda\_create\_announcement) | ./modules/aws_lambda |  |
| <a name="module_aws_lambda_list_announcements"></a> [aws\_lambda\_list\_announcements](#module\_aws\_lambda\_list\_announcements) | ./modules/aws_lambda |  |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.apigateway_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_rest_api.apigateway_announcement_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_dynamodb_table.announcements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_lambda_permission.lambda_create_announcement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lambda_list_announcements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_object.lambda_artifact](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [archive_file.lambda_package](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `""` | no |
| <a name="input_aws_provider_role"></a> [aws\_provider\_role](#input\_aws\_provider\_role) | n/a | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | <pre>{<br>  "ManagedBy": "terraform",<br>  "module": "aws-terragrunt-demo-tf-module-application"<br>}</pre> | no |
| <a name="input_dynamodb_announcements_table_name"></a> [dynamodb\_announcements\_table\_name](#input\_dynamodb\_announcements\_table\_name) | n/a | `string` | `"announcements-table"` | no |
| <a name="input_lambda_artifact_s3_bucket"></a> [lambda\_artifact\_s3\_bucket](#input\_lambda\_artifact\_s3\_bucket) | The s3 bucket for artifacts | `string` | n/a | yes |
| <a name="input_lambda_log_level"></a> [lambda\_log\_level](#input\_lambda\_log\_level) | n/a | `string` | `"DEBUG"` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix for aws resources | `any` | n/a | yes |
| <a name="input_rest_api_stage"></a> [rest\_api\_stage](#input\_rest\_api\_stage) | Api gateway stage name | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Application name wich will added to resources names | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
