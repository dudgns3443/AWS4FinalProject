provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "db/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile = "bespin-aws4"
    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}


module "db" {
  # source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/db?ref=db-v0.0.1"
  source = "../../terrafrom_template/ec2_bastion"
  remote_bucket_name = "aws4-terraform-state"
}