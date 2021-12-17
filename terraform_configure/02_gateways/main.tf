provider "aws" {
  region = "ap-northeast-2"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "gateways/terraform.tfstate"

    region         = "ap-northeast-2" 

    bucket         = "yhkim-terraform-state"
  }

  required_version = ">= 0.12.0"
}


module "gateways" {
  source = "../../terraform_template/gateway_module"

}

output "vpc1_id_2" {
  value = module.gateways.vpc1_id
}