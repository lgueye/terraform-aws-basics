module "terraform_state_backend" {
  source     = "git::https://github.com/cloudposse/terraform-aws-tfstate-backend.git?ref=tags/0.15.0"
  namespace  = var.namespace
  stage      = var.env
  name       = var.app_name
  attributes = ["state"]
  region     = var.region
}

