resource "aws_iam_role" "web_role" {
  name = "web-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "web_policy" {
    name = "web-policy"
    role = aws_iam_role.web_role.id

    policy = <<EOF
{
        "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:DescribeInstances",
            "elasticloadbalancing:DescribeLoadBalancers"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": "s3:PutObject",
         "Resource": "arn:aws:s3:::bucket-log-kth/*"
      }
   ]
}
  EOF
}
resource "aws_iam_instance_profile" "web_profile" {
  name = "web_profile"
  role = aws_iam_role.web_role.name
}