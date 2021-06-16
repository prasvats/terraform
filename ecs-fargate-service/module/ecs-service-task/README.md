## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_name"></a> [name](#module\_name) | ./codesuite | n/a |
| <a name="module_service_security_group"></a> [service\_security\_group](#module\_service\_security\_group) | terraform-aws-modules/security-group/aws | 4.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener_rule.listner_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_alb_target_group.create_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_appautoscaling_policy.asg_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.logs_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecr_repository.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_service.ecs-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_task_definition) | data source |
| [aws_lb.shared_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_listener) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_vpc.vpc_info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [template_file.container_json](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_port"></a> [app\_port](#input\_app\_port) | Application Port | `any` | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Cluster Id | `any` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU | `number` | `256` | no |
| <a name="input_desire_count"></a> [desire\_count](#input\_desire\_count) | Desire Count | `number` | `1` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS Name for application | `string` | `"example.com"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `any` | n/a | yes |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | Health check Matcher | `string` | `"200"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Health Check Path | `string` | `"/"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Image tag | `string` | `"latest"` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Load Balancer Name | `any` | n/a | yes |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | Listener Port | `number` | `443` | no |
| <a name="input_logs_retention_days"></a> [logs\_retention\_days](#input\_logs\_retention\_days) | Cloudwatch Logs Retention Days | `number` | `7` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Maximum Capacity of ECS Service | `number` | `5` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory | `number` | `512` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Minimum Capacity of ECS Service | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Identifier for the application | `any` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | Priority for Rule | `any` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Scan on Push | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the Infrastructure | `map` | <pre>{<br>  "Environment": "dev",<br>  "Owner": "prashant"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `any` | n/a | yes |
| <a name="input_vpc_subnets"></a> [vpc\_subnets](#input\_vpc\_subnets) | VPC Subnets | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repo"></a> [ecr\_repo](#output\_ecr\_repo) | ECR Repo Name |
| <a name="output_log_group"></a> [log\_group](#output\_log\_group) | Log Group Name |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | ECS Service Name |
| <a name="output_target_group"></a> [target\_group](#output\_target\_group) | Target Group ID for the Service |
| <a name="output_task_defination"></a> [task\_defination](#output\_task\_defination) | ECS task Defination |
