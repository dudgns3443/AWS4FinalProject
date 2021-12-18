provider "aws" {
  region  = "ap-northeast-2"
  profile = "bespin-aws4"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt = true
    key     = "ec2_bastion/terraform.tfstate"

    region  = "ap-northeast-2"
    profile = "bespin-aws4"
    bucket  = "a4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}

module "ef_ebs" {
  source = "../../terraform_template/efs_ebs"
}