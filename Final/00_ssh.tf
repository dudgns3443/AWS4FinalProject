# Provider
provider "aws" {
  region = var.region
}

# #Key-Pair
# resource "aws_key_pair" "A4_key" {
#   key_name = var.key
#   public_key = file("../.ssh/id_rsa.pub")
# }