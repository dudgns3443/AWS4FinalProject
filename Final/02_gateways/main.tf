provider "aws" {
  region = var.region
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "gateways/terraform.tfstate"

    region         = "ap-northeast-2" 

    bucket         = "yhkim-terraform-state"
  }

  required_version = ">= 0.12.0"
}


module "gateways" {
  source = "./gateway_module"

}

