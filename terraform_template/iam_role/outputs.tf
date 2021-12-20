output "describe_profile" {
    value = aws_iam_instance_profile.bastion_profile.name
}

output "dlm_iam_role" {
    value = aws_iam_role.a4_dlm_lifecycle_role.arn
}