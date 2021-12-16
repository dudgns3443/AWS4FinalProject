
provider "aws" {
  region  = "ap-northeast-2"
#   profile = "bespin-training-terraform"
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "network/terraform.tfstate"

    region         = "ap-northeast-2" 

    bucket         = "yhkim-terraform-state"
  }

  required_version = ">= 0.12.0"
}


module "vpc" {
  source = "./vpc"

}
# output "vpc_id" {
#     value = module.vpc.aws_vpc.yhkim_vpc_web.id
# }


# data "terraform_remote_state" "vpc" {
#   backend = "s3"

#   config {
#     bucket
#   }
# }