# Terraform Backend

Each Terraform configuration can specify a backend, which defines where and how operations are performed, where state snapshots are stored, etc.

There are two areas of Terraform's behavior that are determined by the backend:

 - Where state is stored.
 - Where operations are performed.

## Setup S3 Backend

- Setup AWS Proflie [Setup](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

- Export required  environment variable.

```bash
# Export AWS Profile
export AWS_PROFILE=prashant
# Export AWS Region 
export TF_VAR_region=us-east-1
# Export Bucket Name which will be used to store TF State and get created by this terraform script
export TF_VAR_tf_state_bucket=prashant
```

- Run and Configure

```bash
terraform init 
terraform plan 
terraform apply
```

This commands need to be run once only as this will setup

- S3 Bucket - Store State Remotely in S3
- Dynamodb - For state locking
and will be used by the other module.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_table"></a> [dynamodb\_table](#input\_dynamodb\_table) | Name of DynamoDB Table | `string` | `"terraform-app-state"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_tf_state_bucket"></a> [tf\_state\_bucket](#input\_tf\_state\_bucket) | S3 Bucket for TF State | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table"></a> [dynamodb\_table](#output\_dynamodb\_table) | Name of the DynamoDB Table |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | Name of the S3 Bucket |