provider "aws" {
  region  = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt = true
    key     = "backup/terraform.tfstate"

    region = "ap-northeast-2"

    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
    profile        = "bespin-aws4"
  }

  required_version = ">= 0.12.0"
}

module "backup" {
  # source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/backup?ref=backup-v0.01"
  source          = "../../terraform_template/09_backup"
  team            = "aws4"
  purpose         = "dlm"
  role            = "role"
  resource_type   = "INSTANCE"
  interval        = 24
  interval_unit   = "HOURS"
  start_time      = "09:00"
  retain_number   = 3
  target_tag_Name = "bastion"
  remote_bucket_name = var.remote_bucket_name
  region = var.region
  key = var.key
  name = var.name
  az = var.az
  route_cidr_global = var.route_cidr_global
  instance_type = var.instance_type
  bastion_pip = var.bastion_pip
}
