## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 >= 2.7.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| db\_parameter\_group | (Required) - Parameter group, depends on DB engine used | `string` | n/a | yes |
| engine | The database engine to use. For supported values, see the Engine parameter in API action CreateDBInstance. | `string` | n/a | yes |
| engine\_version | (Required) - Database engine version, depends on engine type | `string` | n/a | yes |
| instance\_class | (Required) - Class of RDS instance | `string` | n/a | yes |
| port | (Required) - Database port (\_e.g.\_ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids` | `number` | n/a | yes |
| subnet\_ids | (Required) - List of subnets for the DB | `list(string)` | n/a | yes |
| vpc\_id | (Required) - VPC ID the DB instance will be created in | `string` | n/a | yes |
| allocated\_storage | (Required) - The allocated storage in gibibytes. If max\_allocated\_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. | `number` | `10` | no |
| allow\_all\_egress | (Required) - Whether to allow ALL egress (0.0.0.0/0) from RDS | `bool` | `true` | no |
| allow\_major\_version\_upgrade | (Optional) - Allow major version upgrade | `bool` | `false` | no |
| allowed\_cidr\_blocks | (Optional) - List of CIDR blocks that are allowed ingress to the RDS | `list(string)` | `[]` | no |
| allowed\_security\_groups | (Optional) - List of Security Group IDs that are allowed ingress to RDS | `list(string)` | `[]` | no |
| apply\_immediately | (Optional) - Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| attributes | (Optional) - Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| auto\_minor\_version\_upgrade | (Optional) - Allow automated minor version upgrade (e.g. from Postgres 9.5.3 to Postgres 9.5.4) | `bool` | `true` | no |
| aws\_account\_id | (Optional) - The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars | `string` | `""` | no |
| aws\_assume\_role\_arn | (Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars. | `string` | `""` | no |
| aws\_assume\_role\_external\_id | (Optional) - The external ID to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_assume\_role\_session\_name | (Optional) - The session name to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_region | (Optional) - The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars. | `string` | `""` | no |
| backup\_retention\_period | (Optional) - Backup retention period in days. Must be > 0 to enable backups | `number` | `0` | no |
| backup\_window | (Optional) - When AWS can perform DB snapshots, can't overlap with maintenance window | `string` | `"22:00-03:00"` | no |
| copy\_tags\_to\_snapshot | (Optional) - Copy tags from DB to a snapshot | `bool` | `true` | no |
| db\_name | (Optional) - The name of the database to create when the DB instance is created | `string` | `""` | no |
| db\_options | (Optional) - A list of DB options to apply with an option group. Depends on DB engine | <code><pre>list(object({<br>    db_security_group_memberships  = list(string)<br>    option_name                    = string<br>    port                           = number<br>    version                        = string<br>    vpc_security_group_memberships = list(string)<br><br>    option_settings = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))<br></pre></code> | `[]` | no |
| db\_parameter | (Optional) - A list of DB parameters to apply. Note that parameters may differ from a DB family to another | <code><pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))<br></pre></code> | `[]` | no |
| deletion\_protection | (Optional) - Set to true to enable deletion protection on the RDS instance | `bool` | `false` | no |
| delimiter | (Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| enabled | (Optional) - A Switch that decides whether to create a terraform resource or run a provisioner. Default is true | `bool` | `true` | no |
| environment | (Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod' | `string` | `""` | no |
| existing\_security\_groups | (Optional) - List of existing Security Group IDs to place the cluster into. Set `use_existing_security_groups` to `true` to enable using `existing_security_groups` as Security Groups for the cluster | `list(string)` | `[]` | no |
| final\_snapshot\_identifier | (Optional) - Final snapshot identifier e.g.: some-db-final-snapshot-2019-06-26-06-05 | `string` | `""` | no |
| host\_name | (Optional) - The DB host name created in Route53 | `string` | `"db"` | no |
| iops | (Optional) - The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1'. Default is 0 if rds storage type is not 'io1' | `number` | `0` | no |
| kms\_key\_arn | (Optional) - The ARN of the existing KMS key to encrypt storage | `string` | `""` | no |
| license\_model | (Optional) - License model for this DB. Optional, but required for some DB Engines. Valid values: license-included \| bring-your-own-license \| general-public-license | `string` | `""` | no |
| maintenance\_window | (Optional) - The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC | `string` | `"Mon:03:00-Mon:04:00"` | no |
| major\_engine\_version | (Optional) - Database MAJOR engine version, depends on engine type | `string` | `""` | no |
| max\_allocated\_storage | (Required) - When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated\_storage. Must be greater than or equal to allocated\_storage or 0 to disable Storage Autoscaling. | `number` | `100` | no |
| multi\_az | (Optional) - Set to true if multi AZ deployment must be supported | `bool` | `false` | no |
| name | (Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline' | `string` | `""` | no |
| namespace | (Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core' | `string` | `""` | no |
| option\_group\_name | (Optional) - Name of the DB option group to associate | `string` | `""` | no |
| parameter\_group\_name | (Optional) - Name of the DB parameter group to associate | `string` | `""` | no |
| password | (Optional) - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. | `string` | `""` | no |
| publicly\_accessible | (Optional) - Determines if database can be publicly available (NOT recommended) | `bool` | `false` | no |
| skip\_final\_snapshot | (Optional) - If true (default), no snapshot will be made before deleting DB | `bool` | `true` | no |
| snapshot\_identifier | (Optional) - Snapshot identifier e.g: rds:production-2019-06-26-06-05. If specified, the module create cluster from the snapshot | `string` | `""` | no |
| storage\_encrypted | (Optional) Specifies whether the DB instance is encrypted. The default is false if not specified | `bool` | `false` | no |
| storage\_type | (Optional) - One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD) | `string` | `"standard"` | no |
| tags | (Optional) - Additional tags | `map(string)` | `{}` | no |
| use\_existing\_security\_groups | (Optional) - Flag to enable/disable creation of Security Group in the module. Set to `true` to disable Security Group creation and provide a list of existing security Group IDs in `existing_security_groups` to place the cluster into | `bool` | `false` | no |
| username | (Optional) - Username for the master DB user. | `string` | `""` | no |
| zone\_id | (Optional) -The ID of the DNS Zone in Route53 where a new DNS record will be created for the DB host name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| hostname | RDS hostname |
| instance\_address | Address of the instance |
| instance\_arn | The ARN of the RDS instance. |
| instance\_endpoint | DNS Endpoint of the instance |
| instance\_id | ID of the instance |
| instance\_name | Databse name of the instance |
| option\_group\_id | ID of the Option Group |
| parameter\_group\_id | ID of the Parameter Group |
| password | The password for logging in to the database. |
| security\_group\_id | ID of the Security Group |
| subnet\_group\_id | ID of the Subnet Group |
| username | The username  for logging in to the database. |

