provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "network/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile        = "bespin-aws4"
    bucket         = "a4-terraform-state"
  }

  required_version = ">= 0.12.0"
}


module "vpc" {
  source = "../../terraform_template/network"

}

output "vpc1_id" {
  value = module.vpc.vpc1_id
}