# resource "aws_iam_role" "a4_cw_role" {
#   name = "a4-cw-role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "a4_cw_role_pol" {
#     name = "cw-policy"
#     role = aws_iam_role.a4_cw_role.id
#     policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "cloudwatch:PutMetricData",
#                 "ec2:DescribeVolumes",
#                 "ec2:DescribeTags",
#                 "logs:PutLogEvents",
#                 "logs:DescribeLogStreams",
#                 "logs:DescribeLogGroups",
#                 "logs:CreateLogStream",
#                 "logs:CreateLogGroup"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ssm:GetParameter"
#             ],
#             "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "cloudwatch:PutMetricData",
#                 "ds:CreateComputer",
#                 "ds:DescribeDirectories",
#                 "ec2:DescribeInstanceStatus",
#                 "logs:*",
#                 "ssm:*",
#                 "ec2messages:*"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "iam:CreateServiceLinkedRole",
#             "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*",
#             "Condition": {
#                 "StringLike": {
#                     "iam:AWSServiceName": "ssm.amazonaws.com"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:DeleteServiceLinkedRole",
#                 "iam:GetServiceLinkedRoleDeletionStatus"
#             ],
#             "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
#         }
#     ]
#     }
# EOF
# }

# resource "aws_iam_instance_profile" "cw_role_profile" {
#   name = "cw_role_profile"
#   role = aws_iam_role.a4_cw_role.name
# }