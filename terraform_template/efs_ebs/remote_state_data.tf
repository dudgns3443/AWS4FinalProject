data "terraform_remote_state" "ec2_bastion" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "ec2_bastion/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "sg/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}
