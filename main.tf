module "final_snapshot_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.14.1"
  context    = var.context
  attributes = compact(concat(var.attributes, ["final", "snapshot"]))
}

locals {
  computed_major_engine_version = join(".", slice(split(".", var.engine_version), 0, 2))
  major_engine_version          = var.major_engine_version == "" ? local.computed_major_engine_version : var.major_engine_version
}

resource "aws_db_instance" "default" {
  count             = var.enabled ? 1 : 0
  identifier        = module.rds_label.id
  username          = var.database_user
  password          = var.database_password
  port              = var.database_port
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_arn

  vpc_security_group_ids = concat([aws_security_group.default.*.id], var.associate_security_group_ids)

  db_subnet_group_name        = join("", aws_db_subnet_group.default.*.name)
  parameter_group_name        = join("", aws_db_parameter_group.default.*.name)
  option_group_name           = join("", aws_db_option_group.default.*.name)
  license_model               = var.license_model
  multi_az                    = var.multi_az
  storage_type                = var.storage_type
  iops                        = var.iops
  publicly_accessible         = var.publicly_accessible
  snapshot_identifier         = var.snapshot_identifier
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  skip_final_snapshot         = var.skip_final_snapshot
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  tags                        = module.rds_label.tags
  deletion_protection         = var.deletion_protection
  final_snapshot_identifier   = length(var.final_snapshot_identifier) > 0 ? var.final_snapshot_identifier : module.final_snapshot_label.id
}

resource "aws_db_parameter_group" "default" {
  count  = length(var.parameter_group_name) == 0 && var.enabled ? 1 : 0
  name   = module.rds_param_group.id
  family = var.db_parameter_group
  tags   = module.rds_param_group.tags

  dynamic "parameter" {
    for_each = var.db_parameter
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}

resource "aws_db_option_group" "default" {
  count                = length(var.option_group_name) == 0 && var.enabled ? 1 : 0
  name                 = module.rds_option_group.id
  engine_name          = var.engine
  major_engine_version = local.major_engine_version
  tags                 = module.rds_option_group.tags

  dynamic "option" {
    for_each = var.db_options
    content {
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "default" {
  count      = var.enabled ? 1 : 0
  name       = module.subnet_group_label.id
  subnet_ids = var.subnet_ids
  tags       = module.subnet_group_label.tags
}

resource "aws_security_group" "default" {
  count       = var.enabled ? length(var.security_group_ids) : 0
  name        = module.rds_sg.id
  description = "Allow inbound traffic from the security groups"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = element(var.security_group_ids, count.index)

    }
  }

  dynamic "ingress" {
    for_each = var.ingress_ranges
    content {
      from_port   = 3306
      to_port     = 3305
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }

  dynamic "egress" {
    for_each = var.egress_ranges
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = egress.value
    }
  }
  tags = module.rds_sg.tags
}

# Need to clarify with Roger & Ivan if we're going to need DNS
# module "dns_host_name" {
#   source  = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.3.0"
#   enabled = length(var.dns_zone_id) > 0 && var.enabled ? true : false
#   name    = var.host_name
#   zone_id = var.dns_zone_id
#   records = coalescelist(aws_db_instance.default.*.address, [""])
# }
