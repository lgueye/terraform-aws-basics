
terraform {
  required_version = ">= 0.12"
  backend "s3" {
       region         = var.region
       bucket         = "${var.namespace}-${var.env}-${var.app_name}-state"
       key            = "terraform.tfstate"
       dynamodb_table = "${var.namespace}-${var.env}-${var.app_name}-state-lock"
       encrypt        = true
  }
}
