data "terraform_remote_state" "ec2_bastion" {
  backend = "s3"

  config = {
    bucket = "aws4-terraform-state"
    key    = "ec2_bastion/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "aws4-terraform-state"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = "aws4-terraform-state"
    key    = "sg/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}
