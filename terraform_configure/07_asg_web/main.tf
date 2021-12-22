provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "asg_web/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile        = "bespin-aws4"
    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}


module "web_asg" {
  source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/web_asg_module?ref=asg_web-v0.0.1"
  remote_bucket_name = "aws4-terraform-state"
}
