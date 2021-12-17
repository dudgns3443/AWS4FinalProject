output "vpc1_id"{
    value = data.terraform_remote_state.network.outputs.a4_vpc_web_id
}