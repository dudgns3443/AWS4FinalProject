resource "aws_s3_bucket" "bucket_log_kth" {
  bucket = "bucket-log-kth"
  acl    = "private"
  force_destroy = true
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::600734575887:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::bucket-log-kth/*"
    }
  ]
}
  EOF

  lifecycle_rule {
    id      = "log_lifecycle"
    prefix  = ""
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}

# s3 access point
# resource "aws_s3_access_point" "s3_access_point" {
#   bucket = aws_s3_bucket.bucket_log_kth.name
#   name   = "s3-access-point"

#   # VPC must be specified for S3 on Outposts
#   vpc_configuration {
#     vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_web_id
#   }
# }