provider "aws" {
  region  = "ap-northeast-2"
  profile = "bespin-aws4"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt = true
    key     = "ebs_efs/terraform.tfstate"

    region         = "ap-northeast-2"
    profile        = "bespin-aws4"
    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}

module "efs_ebs" {
  # source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/efs_ebs?ref=efs-v0.0.1"
  source = "../../terraform_template/12_efs_ebs"
      remote_bucket_name = var.remote_bucket_name
      region = var.region
      key = var.key
      name = var.name
      az = var.az
      route_cidr_global = var.route_cidr_global
      instance_type = var.instance_type
      bastion_pip = var.bastion_pip
}