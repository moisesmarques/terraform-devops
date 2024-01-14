# terraform-gateway

Development Environment

git checkout dev
terraform init
terraform plan -var 'AWS_ENVIRONMENT_NAME=Development'
terraform apply -var 'AWS_ENVIRONMENT_NAME=Development'


Production Environment

git checkout main
terraform init
terraform plan -var 'AWS_ENVIRONMENT_NAME=Production'
terraform apply -var 'AWS_ENVIRONMENT_NAME=Production'