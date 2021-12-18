resource "aws_efs_file_system" "a4_efs" {
    creation_token = "a4_token"
    availability_zone_name = "ap-northeast-2a"
    tags = { "Name" = "a4-efs" }
    lifecycle_policy {
        transition_to_ia = "AFTER_30_DAYS"
    }
}

resource "aws_efs_mount_target" "a4_efs_mount" {
    file_system_id = aws_efs_file_system.a4_efs.id
    subnet_id = data.terraform_remote_state.network.outputs.a4_sub_pub_web[0].id
    ip_address = "10.10.0.100"
    security_groups = [data.terraform_remote_state.sg.outputs.efs_sg_id]
}

resource "aws_efs_access_point" "a4_access_point" {
  file_system_id = aws_efs_file_system.a4_efs.id
  root_directory {
      path = "/efs"
  }
  tags = { "Name" = "a4-access-point"}
}