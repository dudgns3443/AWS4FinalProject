data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
    profile        = "bespin-aws4"
  }
}
