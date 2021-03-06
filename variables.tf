# -----------------------------------------------------------------------------
# Variables: Common AWS Provider - Autoloaded from Terragrunt
# -----------------------------------------------------------------------------

variable "aws_region" {
  description = "(Optional) - The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

variable "aws_account_id" {
  description = "(Optional) - The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars"
  type        = string
  default     = ""
}

variable "aws_assume_role_arn" {
  description = "(Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars."
  type        = string
  default     = ""
}

variable "aws_assume_role_session_name" {
  description = "(Optional) - The session name to use when making the AssumeRole call."
  type        = string
  default     = ""
}

variable "aws_assume_role_external_id" {
  description = "(Optional) - The external ID to use when making the AssumeRole call."
  type        = string
  default     = ""
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-RDS 
# -----------------------------------------------------------------------------

variable "enabled" {
  description = "(Optional) - A Switch that decides whether to create a terraform resource or run a provisioner. Default is true"
  type        = bool
  default     = true
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "(Optional) -The ID of the DNS Zone in Route53 where a new DNS record will be created for the DB host name"
}

variable "host_name" {
  type        = string
  default     = "db"
  description = "(Optional) - The DB host name created in Route53"
}

variable "db_name" {
  type        = string
  description = "(Optional) - The name of the database to create when the DB instance is created"
  default     = ""
}

variable "username" {
  type        = string
  default     = ""
  description = "(Optional) - Username for the master DB user."
}

variable "password" {
  type        = string
  default     = ""
  description = "(Optional) - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
}

variable "port" {
  type        = number
  description = "(Required) - Database port (_e.g._ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids`"
}

variable "deletion_protection" {
  type        = bool
  description = "(Optional) - Set to true to enable deletion protection on the RDS instance"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "(Optional) - Set to true if multi AZ deployment must be supported"
  default     = false
}

variable "storage_type" {
  type        = string
  description = "(Optional) - One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  default     = "standard"
}

variable "storage_encrypted" {
  type        = bool
  description = "(Optional) Specifies whether the DB instance is encrypted. The default is false if not specified"
  default     = false
}

variable "iops" {
  type        = number
  description = "(Optional) - The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'. Default is 0 if rds storage type is not 'io1'"
  default     = 0
}

variable "allocated_storage" {
  type        = number
  description = "(Required) - The allocated storage in gibibytes. If max_allocated_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs."
  default     = 10
}

variable "max_allocated_storage" {
  type        = number
  description = "(Required) - When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated_storage. Must be greater than or equal to allocated_storage or 0 to disable Storage Autoscaling."
  default     = 100
}

variable "engine" {
  type        = string
  description = "The database engine to use. For supported values, see the Engine parameter in API action CreateDBInstance."
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
}

variable "engine_version" {
  type        = string
  description = "(Required) - Database engine version, depends on engine type"
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
}

variable "major_engine_version" {
  type        = string
  description = "(Optional) - Database MAJOR engine version, depends on engine type"
  default     = ""
  # https://docs.aws.amazon.com/cli/latest/reference/rds/create-option-group.html
}

variable "license_model" {
  type        = string
  description = "(Optional) - License model for this DB. Optional, but required for some DB Engines. Valid values: license-included | bring-your-own-license | general-public-license"
  default     = ""
}

variable "instance_class" {
  type        = string
  description = "(Required) - Class of RDS instance"
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
}

# This is for custom parameters to be passed to the DB
# We're "cloning" default ones, but we need to specify which should be copied
variable "db_parameter_group" {
  type        = string
  description = "(Required) - Parameter group, depends on DB engine used"
  # "mysql5.6"
  # "postgres9.5"
}

variable "publicly_accessible" {
  type        = bool
  description = "(Optional) - Determines if database can be publicly available (NOT recommended)"
  default     = false
}

variable "subnet_ids" {
  description = "(Required) - List of subnets for the DB"
  type        = list(string)
}

variable "vpc_id" {
  type        = string
  description = "(Required) - VPC ID the DB instance will be created in"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "(Optional) - Allow automated minor version upgrade (e.g. from Postgres 9.5.3 to Postgres 9.5.4)"
  default     = true
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "(Optional) - Allow major version upgrade"
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "(Optional) - Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = "(Optional) - The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "Mon:03:00-Mon:04:00"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "(Optional) - If true (default), no snapshot will be made before deleting DB"
  default     = true
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "(Optional) - Copy tags from DB to a snapshot"
  default     = true
}

variable "backup_retention_period" {
  type        = number
  description = "(Optional) - Backup retention period in days. Must be > 0 to enable backups"
  default     = 0
}

variable "backup_window" {
  type        = string
  description = "(Optional) - When AWS can perform DB snapshots, can't overlap with maintenance window"
  default     = "22:00-03:00"
}

variable "db_parameter" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "(Optional) - A list of DB parameters to apply. Note that parameters may differ from a DB family to another"
}

variable "db_options" {
  type = list(object({
    db_security_group_memberships  = list(string)
    option_name                    = string
    port                           = number
    version                        = string
    vpc_security_group_memberships = list(string)

    option_settings = list(object({
      name  = string
      value = string
    }))
  }))

  default     = []
  description = "(Optional) - A list of DB options to apply with an option group. Depends on DB engine"
}

variable "snapshot_identifier" {
  type        = string
  description = "(Optional) - Snapshot identifier e.g: rds:production-2019-06-26-06-05. If specified, the module create cluster from the snapshot"
  default     = ""
}

variable "final_snapshot_identifier" {
  type        = string
  description = "(Optional) - Final snapshot identifier e.g.: some-db-final-snapshot-2019-06-26-06-05"
  default     = ""
}

variable "parameter_group_name" {
  type        = string
  description = "(Optional) - Name of the DB parameter group to associate"
  default     = ""
}

variable "option_group_name" {
  type        = string
  description = "(Optional) - Name of the DB option group to associate"
  default     = ""
}

variable "kms_key_arn" {
  type        = string
  description = "(Optional) - The ARN of the existing KMS key to encrypt storage"
  default     = ""
}

variable "use_existing_security_groups" {
  type        = bool
  description = "(Optional) - Flag to enable/disable creation of Security Group in the module. Set to `true` to disable Security Group creation and provide a list of existing security Group IDs in `existing_security_groups` to place the cluster into"
  default     = false
}

variable "existing_security_groups" {
  type        = list(string)
  default     = []
  description = "(Optional) - List of existing Security Group IDs to place the cluster into. Set `use_existing_security_groups` to `true` to enable using `existing_security_groups` as Security Groups for the cluster"
}

variable "allowed_security_groups" {
  type        = list(string)
  default     = []
  description = "(Optional) - List of Security Group IDs that are allowed ingress to RDS"
}

variable "allow_all_egress" {
  type        = bool
  description = "(Required) - Whether to allow ALL egress (0.0.0.0/0) from RDS"
  default     = true
}

variable "allow_all_self" {
  type        = bool
  description = "If true, the security group itself will be added as a source to this egress rule."
  default     = true
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "(Optional) - List of CIDR blocks that are allowed ingress to the RDS"
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-LABEL
# -----------------------------------------------------------------------------

variable "namespace" {
  type        = string
  default     = ""
  description = "(Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "(Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod'"
}

variable "name" {
  type        = string
  default     = ""
  description = "(Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline'"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "(Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "(Optional) - Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) - Additional tags"
}
