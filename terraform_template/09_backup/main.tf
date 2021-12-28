# DLM

resource "aws_dlm_lifecycle_policy" "a4_dlm_lfc_pol" {
    description = "Team A4 DLM lifecycle policy"
    execution_role_arn = data.terraform_remote_state.iam.outputs.dlm_iam_role
    state = "ENABLED"

    policy_details {
      resource_types = ["${var.resource_type}"]

      schedule {
          name = "2 weeks of daily snapshots"


        # 09:00 UTC에 시작해 24시간 마다
          create_rule {
              interval = var.interval # "24"
              interval_unit = "${var.interval_unit}" # "HOURS"
              times = ["${var.start_time}"]
          }
        # 최대 3개 보존
          retain_rule {
              count = var.retain_number
          }

          tags_to_add = {
              SnapshotCreator = "${var.team}"
          }
        # 소스에서 태그 복사
           copy_tags = true
      }
      # 타겟 태그
      target_tags = {
          Name = "control"
      }

    }
 tags = {
     "Name" = "${var.team}-${var.purpose}"
 }
}