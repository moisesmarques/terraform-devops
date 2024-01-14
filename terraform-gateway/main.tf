   
locals {
  region = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
}

module "dynmodb" {
    source = "./dynmodb"
    environment = var.AWS_ENVIRONMENT_NAME
}

 module "sqs" {
   source = "./sqs"
   environment = var.AWS_ENVIRONMENT_NAME
 }


module "parameter_store" {
  source = "./parameterstore"
}




























