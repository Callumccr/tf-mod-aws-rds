module "label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = ["rds"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}
module "subnet_group_label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context            = module.label.context
  attributes         = ["subnet-group"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
module "rds_param_group" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context            = module.label.context
  attributes         = ["parameter-group"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}

module "rds_option_group" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context            = module.label.context
  attributes         = ["option-group"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
module "rds_sg" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  context            = module.label.context
  attributes         = ["sg"]
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
}
