module "label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context            = var.context
  attributes         = ["rds"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}