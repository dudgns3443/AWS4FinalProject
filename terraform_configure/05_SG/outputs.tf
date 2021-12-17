output "alb_sg_id" {
    value = module.sg.alb_sg_id
}

output "bastion_sg_id" {
    value = module.sg.bastion_sg_id
}

output "db_sg" {
    value = module.sg.db_sg_id
}

output "efs_sg" {
    value = module.sg.efs_sg_id
}

output "gi_sg" {
    value = module.sg.gi_sg_id
}

output "was_sg" {
    value = module.sg.was_sg_id
}

output "web_sg" {
    value = module.sg.web_sg_id
}