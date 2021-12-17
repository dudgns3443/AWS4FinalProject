provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_s3_bucket" "bucket_terraform_state" {
  bucket = "a4-terraform-state"
  acl    = "private"

}

resource "aws_s3_bucket_public_access_block" "bucket_block_public_access" {
  bucket = aws_s3_bucket.bucket_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}