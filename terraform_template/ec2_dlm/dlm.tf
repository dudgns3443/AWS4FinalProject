resource "aws_iam_role" "a4_dlm_lifecycle_role" {
  name = "a4-dlm-lifecycle-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "a4_dlm_role_pol" {
    name = "a4-dlm-lc-pol"
    role = aws_iam_role.a4_dlm_lifecycle_role.id

    policy = <<EOF
{
        "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateSnapshot",
            "ec2:CreateSnapshots",
            "ec2:DeleteSnapshot",
            "ec2:DescribeInstances",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
         ],
         "Resource": "*"
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

resource "aws_dlm_lifecycle_policy" "a4_dlm_lfc_pol" {
    description = "Team A4 DLM lifecycle policy"
    execution_role_arn = aws_iam_role.a4_dlm_lifecycle_role.arn
    state = "ENABLED"

    policy_details {
      resource_types = ["INSTANCE"]

      schedule {
          name = "2 weeks of daily snapshots"


        # 09:00 UTC에 시작해 24시간 마다
          create_rule {
              interval = 24
              interval_unit = "HOURS"
              times = ["09:00"]
          }
        # 최대 3개 보존
          retain_rule {
              count = 3
          }

          tags_to_add = {
              SnapshotCreator = "aws4"
          }
        # 소스에서 태그 복사
           copy_tags = true
      }
      # 타겟 태그
      target_tags = {
          Name = "bastion"
      }

    }
 tags = {
     "Name" = "aws4-dlm"
 }
}

