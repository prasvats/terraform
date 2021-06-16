# AWS Resource Involved

- Create a VPC, Private and Public Subnet.
- Create ALB and Listener on 80.
- Create a ECS Cluster.

## Export Required Environment Variable

```bash
# Export AWS Profile
export AWS_PROFILE=prashant
# Export AWS Region 
export TF_VAR_region=us-east-1
# Export Bucket Name which will be used to store TF State
export TF_VAR_tf_state_bucket=prashant
```

## Add AWS Backend Config

As vairbale is not supported in backend block we need to manually replace the required value in below code snippet and add the content in tf.

```bash
terraform {
  required_version = ">= 0.14.7"

  backend "s3" {
    bucket         = prashant
    key            = "network/vpc.tfstate"
    region         = us-east-1
    encrypt        = true
    dynamodb_table = terraform-app-state
  }
}
```

## Note: Please go through the variable.tf of each module

Step1: Initialize the terraform directory

```bash
terraform init
```

Step2: Check the action Plan or dry run

```bash
terraform plan 
```

Step3: Apply the changes

```bash
terraform apply
```

## Overide Variable

we can also explicitly define a variable

- From a file:

File Content of **secret.tfvars**

```bash
 keypair = "oregon"
 region = "us-west-2"
```

command

```bash
terraform apply  -var-file="secret.tfvars"
```

- Command Line
we can also explicitly define variable

Command

```bash
terraform apply  -var 'keypair=oregon'
```

## Excution Steps

create variable.tfvars with all the variable defined in variable.tf file defined in this directory

```bash
terraform plan -var-file="variable.tfvars"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.42.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_shared_alb"></a> [shared\_alb](#module\_shared\_alb) | terraform-aws-modules/alb/aws | 6.1.0 |
| <a name="module_shared_alb_security_group"></a> [shared\_alb\_security\_group](#module\_shared\_alb\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Identifier for the application | `any` | n/a | yes |
| <a name="input_private_cidrs"></a> [private\_cidrs](#input\_private\_cidrs) | Public Subnet cidr block. Example: 10.0.3.0/24 at least 3 | `list` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_public_cidrs"></a> [public\_cidrs](#input\_public\_cidrs) | Public Subnet cidr block. Example: 10.0.1.0/24 at least 3 | `list` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24",<br>  "10.0.103.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which you are working | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the Infrastructure | `map` | <pre>{<br>  "Environment": "dev",<br>  "Owner": "prashant"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr block. Example: 10.0.0.0/16 | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | A list of availability zones spefified as argument to this module |
| <a name="output_ecs_cluster"></a> [ecs\_cluster](#output\_ecs\_cluster) | ECS Cluster Name |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | ECS Cluster ARN |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The ID and ARN of the load balancer we created. |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS name of the load balancer. |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | The ID and ARN of the load balancer we created. |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for AWS NAT Gateway |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |