data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "yhkim-terraform-state"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
