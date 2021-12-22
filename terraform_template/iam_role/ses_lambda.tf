resource "aws_iam_role" "a4_lambda_iam" {
  name = "lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "a4_lambda_policy" {
  name        = "lambda-ses-policy"
  path        = "/"
  role = aws_iam_role.a4_lambda_iam.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
            "s3:*",
            "ses:*"
      ],
      "Resource" : "*"
      "Effect": "Allow"
    }
  ]
}
EOF
}