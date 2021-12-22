provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "lambda/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile        = "bespin-aws4"
    bucket  = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}


module "lambda" {
  source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/lambda?ref=lambda-v0.0.1"

}