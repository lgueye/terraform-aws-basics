module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

locals {
  mq_admin_user           = length(var.mq_admin_user) > 0 ? var.mq_admin_user : random_string.mq_admin_user.result
  mq_admin_password       = length(var.mq_admin_password) > 0 ? var.mq_admin_password : random_string.mq_admin_password.result
  mq_application_user     = length(var.mq_application_user) > 0 ? var.mq_application_user : random_string.mq_application_user.result
  mq_application_password = length(var.mq_application_password) > 0 ? var.mq_application_password : random_string.mq_application_password.result
}

resource "random_string" "mq_admin_user" {
  length  = 8
  special = false
  number  = false
}

resource "random_string" "mq_admin_password" {
  length  = 16
  special = false
}

resource "random_string" "mq_application_user" {
  length  = 8
  special = false
  number  = false
}

resource "random_string" "mq_application_password" {
  length  = 16
  special = false
}

resource "aws_mq_broker" "default" {
  broker_name                = module.label.id
  deployment_mode            = var.deployment_mode
  engine_type                = var.engine_type
  engine_version             = var.engine_version
  host_instance_type         = var.host_instance_type
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately
  publicly_accessible        = var.publicly_accessible
  security_groups            = [join("", aws_security_group.default.*.id)]
  subnet_ids                 = var.subnet_ids

  logs {
    general = var.general_log
    audit   = var.audit_log
  }

  maintenance_window_start_time {
    day_of_week = var.maintenance_day_of_week
    time_of_day = var.maintenance_time_of_day
    time_zone   = var.maintenance_time_zone
  }

  user {
      username       = local.mq_admin_user
      password       = local.mq_admin_password
      groups         = ["admin"]
      console_access = true
  }
  user {
      username       = local.mq_application_user
      password       = local.mq_application_password
  }

}

resource "aws_security_group" "default" {
  vpc_id = var.vpc_id
  name   = module.label.id
  tags   = module.label.tags
}

resource "aws_security_group_rule" "default" {
  count                    = length(var.security_groups) > 0 ? length(var.security_groups) : 0
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "0"
  to_port                  = "0"
  source_security_group_id = element(var.security_groups, count.index)
  security_group_id        = aws_security_group.default.id
}
