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
    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}

module "nlb" {
  source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/nlb_module?ref=nlb-v0.0.1""
  remote_bucket_name = "aws4-terraform-state"
}