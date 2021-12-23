# output of lambda arn
output "ses_lambda" {
  value = aws_lambda_function.ses_lambda.arn
}