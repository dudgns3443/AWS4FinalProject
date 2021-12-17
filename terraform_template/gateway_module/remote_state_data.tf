data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
