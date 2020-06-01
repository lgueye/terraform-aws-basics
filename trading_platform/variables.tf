variable "region" {
  type = string
  default = "eu-central-1"
}

variable "namespace" {
  type = string
  default = "agileinfra-io"
}

variable "env" {
  type = string
  default = "staging"
}

variable "app_name" {
  type = string
  default = "trading-platform"
}

# VPC

variable vpc_cidr_block {
  type = string
  default = "10.0.0.0/16"
}

# Broker
variable broker_root_user {
  type = string
  default = "broker_root"
}

variable broker_root_password {
  type = string
}

variable broker_application_password {
  type = string
}
