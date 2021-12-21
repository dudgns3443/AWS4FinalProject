data "aws_iam_policy_document" "dlm_assume_role_pol" {
    statement {
      actions = ["sts:AssumeRole"]

      principals {
          type = "Service"
          identifiers = ["dlm.amazonaws.com"]
      }
    }
}
variable "remote_bucket_name" {
  type        = string
  default     = null
}