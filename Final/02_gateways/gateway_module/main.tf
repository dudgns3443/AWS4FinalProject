data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "yhkim-terraform-state"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data.terraform_remote_state.vpc.outputs.subnet_id