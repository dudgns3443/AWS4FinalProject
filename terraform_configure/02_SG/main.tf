provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "sg/terraform.tfstate"

    region         = "ap-northeast-2" 

    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
    profile = "bespin-aws4"
  }

  required_version = ">= 0.12.0"
}

module "sg" {
    source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//sg_module?ref=sg-v0.0.1"
    remote_bucket_name = "aws4-terraform-state"
}