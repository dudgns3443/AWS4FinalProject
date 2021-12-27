# 선언할게 없음

output "bastion_id" {
    value = aws_instance.bastion.id
}

output "control_id" {
    value = aws_instance.control.id
}