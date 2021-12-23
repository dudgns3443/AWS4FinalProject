#VPC-Was NLB
resource "aws_lb" "a4_nlb" {
  name = "${var.name}-nlb"
  internal = true
  load_balancer_type = var.lb_type[1]
  subnets = [data.terraform_remote_state.network.outputs.a4_sub_pri_was[0].id,data.terraform_remote_state.network.outputs.a4_sub_pri_was[1].id]

  #   access_logs {
  #   bucket  = "bucket-log-kth"
  #   prefix  = "nlb"
  #   enabled = true
  # }

  tags = {
    "Name" = "${var.name}-nlb"
  }
}

#VPC-Was NLB Target Group 
resource "aws_lb_target_group" "a4_tomcat_nlbtg" {
  name = "a4-tomcat-nlbtg"
  port = var.port_tomcat
  protocol = var.b_protocol
  vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_was_id
  target_type = var.target_type
}

#VPC-Was NLB listener
resource "aws_lb_listener" "a4_tomcat_nlblis" {
  load_balancer_arn = aws_lb.a4_nlb.arn
  port = var.port_tomcat
  protocol = var.b_protocol
  
  default_action {
    type = var.lis_default_action
    target_group_arn = aws_lb_target_group.a4_tomcat_nlbtg.arn
  }
}

# s3 nlb access point => 권한 문제 오류가 남
# # s3 access point
# resource "aws_s3_access_point" "s3_access_point_nlb" {
#   bucket = "bucket-log-kth"
#   name   = "s3-access-point-nlb"

#   # VPC must be specified for S3 on Outposts
#   vpc_configuration {
#     vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_was_id
#   }
# }