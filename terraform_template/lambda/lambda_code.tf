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
      "Resource" : "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

#람다 리소스 작성
resource "aws_lambda_function" "ses_lambda" {
  function_name    = "ses-function_name"
  role             = aws_iam_role.a4_lambda_iam.arn
  handler          = "src/lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = "900"
  filename         = "../src.zip"
  source_code_hash = filebase64sha256("../src.zip")
  environment {
    variables = {
      env            = "dev"
      SENDER_EMAIL   = "kimjoe1997@naver.com"
      RECEIVER_EMAIL = "sbs880824@gmail.com"
    }
  }
}

# 람다 함수로 호출하기 위한 s3 리소스 만들기
resource "aws_s3_bucket" "bucket" {
  bucket = "tesa4-lambda"
  acl    = "private"

  tags = {
    Environment = "dev"
  }
}

# S3 버킷을 내 람다에 트리거로 추가하고 사용 권한 부여
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.ses_lambda.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

  }
}
resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ses_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
}

resource "aws_ses_email_identity" "ses_1" {
  email = "kimjoe1997@naver.com"
}

resource "aws_ses_email_identity" "ses_2" {
  email = "sbs880824@gmail.com"
}