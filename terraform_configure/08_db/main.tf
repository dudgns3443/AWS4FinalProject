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
    bucket         = var.remote_bucket_name
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}


module "a4_golden_img_module" {
  source = "../../terraform_template/db"
  remote_bucket_name = var.remote_bucket_name
}