# Provider
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

#Key-Pair
resource "aws_key_pair" "A4_key" {
  key_name = var.key
  public_key = file("../.ssh/id_rsa.pub")
}