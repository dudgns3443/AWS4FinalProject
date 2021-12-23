output "alb_sg_id" {
    value = aws_security_group.a4_alb_sg.id
}

output "bastion_sg_id" {
    value = aws_security_group.a4_bastion_sg.id
}

output "db_sg_id" {
    value = aws_security_group.a4_db_sg.id
}

output "efs_sg_id" {
    value = aws_security_group.a4_efs_sg.id
}

output "gi_sg_id" {
    value = aws_security_group.a4_gi_sg.id
}

output "was_sg_id" {
    value = aws_security_group.a4_was_sg.id
}

output "web_sg_id" {
    value = aws_security_group.a4_web_sg.id
}

output "redis_sg_id" {
    value = aws_security_group.redis_sg.id
}
