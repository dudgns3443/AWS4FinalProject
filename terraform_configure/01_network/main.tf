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
    bucket         = var.remote_bucket_name
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}


module "network" {
  source = "../../terraform_template/network"
  remote_bucket_name = var.remote_bucket_name
}
