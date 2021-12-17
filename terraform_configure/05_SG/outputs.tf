output "alb_sg_id" {
    value = module.sg.outputs.alb_sg_id
}

output "bastion_sg_id" {
    value = module.sg.outputs.bastion_sg_id
}

output "db_sg" {
    value = module.sg.outputs.db_sg_id
}

output "efs_sg" {
    value = module.sg.outputs.efs_sg_id
}

output "gi_sg" {
    value = module.sg.outputs.gi_sg_id
}

output "was_sg" {
    value = module.sg.outputs.was_sg_id
}

output "web_sg" {
    value = module.sg.outputs.web_sg_id
}