## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 >= 2.7.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allocated\_storage | The allocated storage in GBs | `number` | n/a | yes |
| database\_port | Database port (\_e.g.\_ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids` | `number` | n/a | yes |
| db\_parameter\_group | Parameter group, depends on DB engine used | `string` | n/a | yes |
| engine | Database engine type | `string` | n/a | yes |
| engine\_version | Database engine version, depends on engine type | `string` | n/a | yes |
| instance\_class | Class of RDS instance | `string` | n/a | yes |
| subnet\_ids | List of subnets for the DB | `list(string)` | n/a | yes |
| vpc\_id | VPC ID the DB instance will be created in | `string` | n/a | yes |
| allow\_major\_version\_upgrade | Allow major version upgrade | `bool` | `false` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| associate\_security\_group\_ids | The IDs of the existing security groups to associate with the DB instance | `list(string)` | `[]` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| auto\_minor\_version\_upgrade | Allow automated minor version upgrade (e.g. from Postgres 9.5.3 to Postgres 9.5.4) | `bool` | `true` | no |
| aws\_account\_id | The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars | `string` | `""` | no |
| aws\_assume\_role\_arn | ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars. | `string` | `""` | no |
| aws\_region | The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars. | `string` | `""` | no |
| backup\_retention\_period | Backup retention period in days. Must be > 0 to enable backups | `number` | `0` | no |
| backup\_window | When AWS can perform DB snapshots, can't overlap with maintenance window | `string` | `"22:00-03:00"` | no |
| copy\_tags\_to\_snapshot | Copy tags from DB to a snapshot | `bool` | `true` | no |
| database\_name | The name of the database to create when the DB instance is created | `string` | `""` | no |
| database\_password | (Required unless a snapshot\_identifier or replicate\_source\_db is provided) Password for the master DB user | `string` | `""` | no |
| database\_user | (Required unless a `snapshot_identifier` or `replicate_source_db` is provided) Username for the master DB user | `string` | `""` | no |
| db\_options | A list of DB options to apply with an option group. Depends on DB engine | <code><pre>list(object({<br>    db_security_group_memberships  = list(string)<br>    option_name                    = string<br>    port                           = number<br>    version                        = string<br>    vpc_security_group_memberships = list(string)<br><br>    option_settings = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))<br></pre></code> | `[]` | no |
| db\_parameter | A list of DB parameters to apply. Note that parameters may differ from a DB family to another | <code><pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))<br></pre></code> | `[]` | no |
| deletion\_protection | Set to true to enable deletion protection on the RDS instance | `bool` | `false` | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| dns\_zone\_id | The ID of the DNS Zone in Route53 where a new DNS record will be created for the DB host name | `string` | `""` | no |
| egress\_ranges | RDS egress ranges | `list(string)` | <code><pre>[<br>  "52.94.13.0/24",<br>  "54.231.240.0/22",<br>  "52.95.128.0/21",<br>  "52.92.52.0/22",<br>  "52.219.32.0/21",<br>  "52.219.40.0/22",<br>  "54.231.252.0/24",<br>  "54.231.248.0/22",<br>  "52.219.76.0/22",<br>  "52.92.56.0/22"<br>]<br></pre></code> | no |
| enabled | (Optional). A Switch that decides whether to create a terraform resource or run a provisioner. Default is true | `bool` | `true` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| final\_snapshot\_identifier | Final snapshot identifier e.g.: some-db-final-snapshot-2019-06-26-06-05 | `string` | `""` | no |
| host\_name | The DB host name created in Route53 | `string` | `"db"` | no |
| ingress\_ranges | RDS ingress ranges | `list(string)` | <code><pre>[<br>  "10.1.5.0/24",<br>  "10.212.134.0/24"<br>]<br></pre></code> | no |
| iops | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1'. Default is 0 if rds storage type is not 'io1' | `number` | `0` | no |
| kms\_key\_arn | The ARN of the existing KMS key to encrypt storage | `string` | `""` | no |
| license\_model | License model for this DB. Optional, but required for some DB Engines. Valid values: license-included \| bring-your-own-license \| general-public-license | `string` | `""` | no |
| maintenance\_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC | `string` | `"Mon:03:00-Mon:04:00"` | no |
| major\_engine\_version | Database MAJOR engine version, depends on engine type | `string` | `""` | no |
| multi\_az | Set to true if multi AZ deployment must be supported | `bool` | `false` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| option\_group\_name | Name of the DB option group to associate | `string` | `""` | no |
| parameter\_group\_name | Name of the DB parameter group to associate | `string` | `""` | no |
| publicly\_accessible | Determines if database can be publicly available (NOT recommended) | `bool` | `false` | no |
| security\_group\_ids | Security Group IDs to pass to the module security group for 'ingress' traffic | `list(string)` | `[]` | no |
| service\_ports | MemcacheD service ports | `list(string)` | <code><pre>[<br>  "11211",<br>  "-1",<br>  "1"<br>]<br></pre></code> | no |
| skip\_final\_snapshot | If true (default), no snapshot will be made before deleting DB | `bool` | `true` | no |
| snapshot\_identifier | Snapshot identifier e.g: rds:production-2019-06-26-06-05. If specified, the module create cluster from the snapshot | `string` | `""` | no |
| storage\_encrypted | (Optional) Specifies whether the DB instance is encrypted. The default is false if not specified | `bool` | `false` | no |
| storage\_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD) | `string` | `"standard"` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_address | Address of the instance |
| instance\_arn | The ARN of the RDS instance. |
| instance\_endpoint | DNS Endpoint of the instance |
| instance\_id | ID of the instance |
| option\_group\_id | ID of the Option Group |
| parameter\_group\_id | ID of the Parameter Group |
| security\_group\_id | ID of the Security Group |
| subnet\_group\_id | ID of the Subnet Group |

