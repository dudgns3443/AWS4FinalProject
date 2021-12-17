data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "yhkim-terraform-state"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
