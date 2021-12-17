output "alb_sg_id" {
    value = aws_security_group.alb_sg.id
}

output "bastion_sg_id" {
    value = aws_security_group.bastion_sg.id
}

output "db_sg" {
    value = aws_security_group.db_sg.id
}

output "efs_sg" {
    value = aws_security_group.efs_sg.id
}

output "gi_sg" {
    value = aws_security_group.gi_sg.id
}

output "was_sg" {
    value = aws_security_group.was_sg.id
}

output "web_sg" {
    value = aws_security_group.web_sg.id
}