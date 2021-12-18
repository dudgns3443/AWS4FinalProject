output "a4_dlm_lfc_policy" {
    value = aws_dlm_lifecycle_policy.a4_dlm_lfc_pol.id
}

output "a4_lifecycle_role_arn" {
    value = aws_iam_role.a4_dlm_lifecycle_role.arn
}
