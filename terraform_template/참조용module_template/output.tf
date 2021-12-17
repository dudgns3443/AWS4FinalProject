output "vpc1_id"{
    value = data.terraform_remote_state.vpc.outputs.vpc1_id
}