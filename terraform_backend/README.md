This module creates the AWS S3 backend: an S3 bucket and a Dynamo table.

This module can't be run inside the module that uses the backend otherwise destroying the module would also destroy.

The execution would then fail when the module would like to persist the state since the backend is destroyed.
  
`terraform init`

`terraform plan`

`terraform apply -auto-approve`