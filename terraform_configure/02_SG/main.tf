provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "sg/terraform.tfstate"

    region         = "ap-northeast-2" 

    bucket         = "a4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
    profile = "bespin-aws4"
  }

  required_version = ">= 0.12.0"
}

module "sg" {
    source = "../../terraform_template/sg_module"
}