resource "aws_iam_role" "log_exporter" {
  name = "log-exporter"

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

resource "aws_iam_role_policy" "log_exporter" {
  name = "log-exporter"
  role = aws_iam_role.log_exporter.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateExportTask",
        "logs:Describe*",
        "logs:ListTagsLogGroup"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:DescribeParameters",
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
        "ssm:PutParameter"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
        "Sid": "AllowCrossAccountObjectAcc",
        "Effect": "Allow",
        "Action": [
            "s3:PutObject",
            "s3:PutObjectACL"
        ],
        "Resource": "arn:aws:s3:::bucket-log-a4/*"
    },
    {
        "Sid": "AllowCrossAccountBucketAcc",
        "Effect": "Allow",
        "Action": [
            "s3:PutBucketAcl",
            "s3:GetBucketAcl"
        ],
        "Resource": "arn:aws:s3:::bucket-log-a4"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "log_exporter" {
  filename         = "cloudwatch_to_s3.zip"
  function_name    = "log-exporter"
  role             = aws_iam_role.log_exporter.arn
  handler          = "cloudwatch_to_s3.lambda_handler"
  source_code_hash = filebase64sha256("cloudwatch_to_s3.zip")
  timeout          = 300

  runtime = "python3.8"

  environment {
    variables = {
      S3_BUCKET = "bucket-log-a4",
    }
  }
}

resource "aws_cloudwatch_event_rule" "log_exporter" {
  name                = "log-exporter"
  description         = "Fires periodically to export logs to S3"
  schedule_expression = "cron(59 23 * * ? *)"
}

resource "aws_cloudwatch_event_target" "log_exporter" {
  rule      = aws_cloudwatch_event_rule.log_exporter.name
  target_id = "log-exporter"
  arn       = aws_lambda_function.log_exporter.arn
}

resource "aws_lambda_permission" "log_exporter" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log_exporter.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.log_exporter.arn
}