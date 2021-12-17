provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "gateways/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile = "bespin-aws4"
    bucket         = "a4-terraform-state"
  }

  required_version = ">= 0.12.0"
}


module "gateways" {
  source = "../../terraform_template/참조용module_template"

}

output "a4_vpc_web_id" {
  value = module.gateways.vpc1_id
}