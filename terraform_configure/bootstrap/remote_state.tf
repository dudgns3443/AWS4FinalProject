provider "aws" {
  region  = "ap-northeast-2"
  profile = "bespin-aws4"
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

resource "aws_dynamodb_table" "table_terraform_locks" {
  name           = "a4-terraform-locks"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "a4-terraform-locks"
    Description = "Terraform locks table"
  }
}