resource "aws_iam_role" "ec2_elb_describe_role" {
  name = "ec2_elb_describe_role"

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
    name = "ec2_elb_describe_role"
    role = aws_iam_role.ec2_elb_describe_role.id

    policy = <<EOF
{
        "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:DescribeInstances",
            "elasticloadbalancing:DescribeLoadBalancers",
            "ec2:Describe*",
            "elasticache:Describe*",
            "rds:Describe*",
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets"
         ],
         "Resource": "*"
      }
   ]
    }
  EOF
}
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = aws_iam_role.ec2_elb_describe_role.name
}