provider "aws" {
  region = "ap-northeast-2"
  access_key = "AKIAUD6MY25DV6O33747"
  secret_key = "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"
}

# iam 역할 부여
resource "aws_iam_role" "a4_dlm_lifecycle_role" {

  name = "a4-dlm"

  assume_role_policy = jsonencode(
 {
    Version: "2012-10-17",
    Statement: [
        {
            Effect: "Allow",
            Action: [
                "ec2:CreateSnapshot",
                "ec2:CreateSnapshots",
                "ec2:DeleteSnapshot",
                "ec2:DescribeInstances",
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:EnableFastSnapshotRestores",
                "ec2:DescribeFastSnapshotRestores",
                "ec2:DisableFastSnapshotRestores",
                "ec2:CopySnapshot",
                "ec2:ModifySnapshotAttribute",
                "ec2:DescribeSnapshotAttribute",
            ]
            Resource: "*"
        },
        {
            Effect: "Allow",
            Action: [
                "ec2:CreateTags",
            ]
            Resource: "arn:aws:ec2:*::snapshot/*"
        },
        {
            Effect: "Allow",
            Action: [
                "ec2:CreateTags",
                "events:PutRule",
                "events:DeleteRule",
                "events:DescribeRule",
                "events:EnableRule",
                "events:DisableRule",
                "events:ListTargetsByRule",
                "eventts:PutTargets",
                "events:RemoveTargets",
            ]
            Resource: "arn:aws:events:*:*:rule/AwsDataLifecycleRule.managed-cwe.*"
        },
    ]
  }
)
}
/*
resource "aws_dlm_lifecycle_policy" "a4_dlm_lifecycle_policy" {
    description = "Team A4 dlm LifeCycle Policy"
    execution_role_arn = aws_iam_role.a4_dlm_lifecycle_role.arn
    state = "ENABLED"

    policy_details {
      resource_types = ["INSTANCE"]

      schedule {
        name = "2 weeks of daily snapshots"

        create_rule {
          interval = 24
          interval_unit = "HOURS"
          times = ["23:45"]
        }

        retain_rule {
          count = 3
        }

        tags_to_add = {
            SnapshotCreator = "DLM"
        }

        copy_tags = true

      }

      target_tags = {
          snapshot = "true"
      }



    }

    

}
*/