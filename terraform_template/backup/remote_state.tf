data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "iam/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}
