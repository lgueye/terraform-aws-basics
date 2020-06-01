Setup
====

- create aws account

- secure root account (5 steps)

- create IAM user

- enable API access for IAM

- download aw-cli

- configure aws-cli

- Terraform

	- backend state bootstrap: cloudposse module https://github.com/cloudposse/terraform-aws-tfstate-backend/
	- fix "region required issue" https://github.com/cloudposse/terraform-aws-tfstate-backend/issues/42
	- terraform plan
	- terraform apply
	- configure newly created backend
	- terraform plan
	- terraform apply
