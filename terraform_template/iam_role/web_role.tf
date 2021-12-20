resource "aws_iam_role" "a4_web_role" {
  name = "${var.team}-web-role"

  assume_role_policy = <<EOF
{
  "Version": "2020-12-20",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "a4_web_role_pol" {
    name = "${var.team}-web-policy"
    role = aws_iam_role.a4_web_role.id

    policy = <<EOF
{
        "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "s3:PutObject",
            "cloudwatch:CloudWatchAgentServerPolicy",
         ],
         "Resource": "arn:aws:s3:::bucket-log-kth/*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateTags"
         ],
         "Resource": "arn:aws:ec2:*::snapshot/*"
  }
   ]
    }
  EOF
}

