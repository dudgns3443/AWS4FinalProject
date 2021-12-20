resource "aws_iam_role" "ec2_elb_describe_role" {
  name = "a4-dlm-lifecycle-role"

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

resource "aws_iam_role_policy" "describe_policy" {
    name = "a4-dlm-lc-pol"
    role = aws_iam_role.ec2_elb_describe_role.id

    policy = <<EOF
{
        "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:DescribeInstances",
            "elb:DescribeLoadBalancers"
         ],
         "Resource": "*"
      },
   ]
    }
  EOF
}
