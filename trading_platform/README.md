This module creates creates the trading platform infrastructure:

- broker: amazon mq module
- persistence: amazon rds module
- app runtime: amazon eks

Pre-requisites:

- make sure you properly created an S3 bucket to store the terraform state
- be sure to get the following passwords
    - broker root password 
    - broker application password 
    - database root password 
    - database application password 

`terraform init`

`terraform plan`

`terraform apply -auto-approve`