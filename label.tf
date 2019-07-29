module "rds_label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context            = var.context
  attributes         = ["rds"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
module "subnet_group_label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context            = var.context
  attributes         = ["rds-subnet-group"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
module "rds_param_group" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context            = var.context
  attributes         = ["rds-pg"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}

module "rds_option_group" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context            = var.context
  attributes         = ["rds-og"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
module "rds_sg" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context            = var.context
  attributes         = ["rds-sg"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
