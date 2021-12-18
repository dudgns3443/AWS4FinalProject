data "terraform_remote_state" "ec2_bastion" {
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "ec2_bastion/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

