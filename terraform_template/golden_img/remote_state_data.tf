# vpc, subnet, ig, ng, rout-table
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

# security group
data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "sg/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

#iam
data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket = var.remote_bucket_name
    key    = "iam/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}