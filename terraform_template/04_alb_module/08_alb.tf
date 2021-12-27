
#VPC-Web ALB
resource "aws_lb" "a4_alb" {
  name = "${var.name}-alb"
  internal = false
  load_balancer_type = var.lb_type[0]
  security_groups = [data.terraform_remote_state.sg.outputs.alb_sg_id]
  subnets = [data.terraform_remote_state.network.outputs.a4_sub_pub_web[0].id,data.terraform_remote_state.network.outputs.a4_sub_pub_web[1].id]
  #subnets = [aws_subnet.a4_pub[0].id,aws_subnet.a4_pub[1].id]
  
  access_logs {
    bucket  = "bucket-log-a4"
    prefix  = "alb"
    enabled = true
  }
  
  tags = {
    "Name" = "${var.name}-alb"
  }
}

#VPC-Web ALB Target Group
resource "aws_lb_target_group" "a4_http_albtg" {
  name = "a4-http-albtg"
  port = var.port_http
  protocol = var.b_protocol_http
  vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_web_id
  health_check {
    enabled = true
    healthy_threshold = var.healthy_threshold
    interval = var.health_interval
    matcher = var.health_matcher
    path = var.health_path
    port = var.health_port
    timeout = var.health_timeout
    unhealthy_threshold = var.unhealthy_threshold
  }
}
#VPC-Web ALB listener
resource "aws_lb_listener" "a4_http_alblis" {
  load_balancer_arn = aws_lb.a4_alb.arn
  port = var.port_http
  protocol = var.b_protocol_http

  default_action {
    type = var.lis_default_action
    target_group_arn = aws_lb_target_group.a4_http_albtg.arn
  }
}

# s3 access point made by kth
resource "aws_s3_access_point" "s3_access_point" {
  bucket = "bucket-log-a4"
  name   = "s3-access-point"

  # VPC must be specified for S3 on Outposts
  vpc_configuration {
    vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_web_id
  }
}