data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "sg/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}
data "terraform_remote_state" "golden_image" {
  
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "golden_img/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}
data "terraform_remote_state" "alb" {
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "alb/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
}
data "terraform_remote_state" "nlb" {
  backend = "s3"

  config = {
    bucket = "a4-terraform-state"
    key    = "nlb/terraform.tfstate"
    region = "ap-northeast-2"
    profile = "bespin-aws4"
  }
} 