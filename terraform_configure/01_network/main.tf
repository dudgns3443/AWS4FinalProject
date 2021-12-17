provider "aws" {
  region = "ap-northeast-2"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "network/terraform.tfstate"

    region         = "ap-northeast-2" 

    bucket         = "yhkim-terraform-state"
  }

  required_version = ">= 0.12.0"
}


module "vpc" {
  source = "../../terraform_template/vpc_module"

}

output "vpc1_id" {
  value = module.vpc.vpc1_id
}