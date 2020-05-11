module "final_snapshot_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.14.1"
  context    = module.label.context
  attributes = compact(concat(var.attributes, ["final", "snapshot"]))
}

resource "aws_db_instance" "default" {
  count                 = var.enabled ? 1 : 0
  identifier            = module.label.id
  name                  = var.db_name
  username              = var.username
  password              = var.password
  port                  = var.port
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = var.storage_encrypted
  kms_key_id            = var.kms_key_arn

  vpc_security_group_ids = var.use_existing_security_groups == true ? var.existing_security_groups : [aws_security_group.default.0.id]

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
  tags                        = module.label.tags
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
  count  = var.enabled && var.use_existing_security_groups == false ? 1 : 0
  vpc_id = var.vpc_id
  name   = module.rds_sg.id
  tags   = module.rds_sg.tags

  dynamic "ingress" {
    for_each = length(var.allowed_security_groups) > 0 ? [var.port] : null
    iterator = ingress
    content {
      description     = "Allow inbound traffic from existing Security Groups"
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = var.allowed_security_groups
    }
  }

  dynamic "ingress" {
    for_each = length(var.allowed_security_groups) > 0 ? var.allowed_cidr_blocks : null
    iterator = ingress
    content {
      description = "Allow inbound traffic to internal CIDR ranges"
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "egress" {
    for_each = var.allow_all_egress == true ? ["0.0.0.0/0"] : null
    iterator = ingress
    content {
      description = "Allow outbound traffic to internal CIDR ranges"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [ingress.value]
    }
  }
  // self sg rules
  dynamic "ingress" {
    for_each = var.allow_all_self == true ? [""] : null
    iterator = ingress
    content {
      description = "Allow outbound traffic to withn the security group"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      self        = true
    }
  }

  dynamic "egress" {
    for_each = var.allow_all_self == true ? [""] : null
    iterator = ingress
    content {
      description = "Allow outbound traffic to within the security group"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      self        = true
    }
  }
}

module "dns" {
  source  = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.3.0"
  enabled = var.enabled && var.zone_id != "" ? true : false
  name    = var.name
  ttl     = 60
  zone_id = var.zone_id
  records = coalescelist(aws_db_instance.default.*.address, [""])
}
