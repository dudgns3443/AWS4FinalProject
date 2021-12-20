resource "aws_iam_role" "a4_was_role" {
  name = "${var.team}-was-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-12-20",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazon.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "a4_was_role_pol" {
    name = "${var.team}-was-policy"
    role = aws_iam_role.a4_was_role.id
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ec2:DescribeVolumes",
                "ec2:DescribeTags",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
        }
    ]
    }
EOF
}

resource "aws_iam_instance_profile" "was_role_profile" {
  name = "role_profile"
  role = aws_iam_role.a4_was_role.name
}