provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "nlb/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile        = "bespin-aws4"
    bucket         = "a4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}

module "nlb" {
  source = "../../terraform_template/nlb_module"

}