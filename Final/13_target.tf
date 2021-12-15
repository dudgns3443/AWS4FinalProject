resource "aws_lb" "A4_alb" {
  name = "${var.name}-alb"
  internal = false
  load_balancer_type = var.lb_type[0]
  security_groups = [aws_security_group.alb_sg.id]
  subnets = [aws_subnet.A4_pub[0].id,aws_subnet.A4_pub[1].id]
  tags = {
    "Name" = "${var.name}-alb"
  }
}

#### nlb
resource "aws_lb" "A4_nlb" {
  name = "${var.name}-nlb"
  internal = true
  load_balancer_type = var.lb_type[1]
  subnets = [aws_subnet.A4_priwas[0].id,aws_subnet.A4_priwas[1].id]
  tags = {
    "Name" = "${var.name}-nlb"
  }
}

resource "aws_lb_target_group" "A4_http_albtg" {
  name = "A4-http-albtg"
  port = var.port_http
  protocol = var.b_protocol_http
  vpc_id = aws_vpc.A4_vpc_web.id
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

#### nlb_tg 
resource "aws_lb_target_group" "A4_tomcat_nlbtg" {
  name = "A4-tomcat-nlbtg"
  port = var.port_tomcat
  protocol = var.b_protocol
  vpc_id = aws_vpc.A4_vpc_was.id
  target_type = var.target_type
}

resource "aws_lb_listener" "A4_http_alblis" {
  load_balancer_arn = aws_lb.A4_alb.arn
  port = var.port_http
  protocol = var.b_protocol_http

  default_action {
    type = var.lis_default_action
    target_group_arn = aws_lb_target_group.A4_http_albtg.arn
  }
}

#### nlb_listener
resource "aws_lb_listener" "A4_tomcat_nlblis" {
  load_balancer_arn = aws_lb.A4_nlb.arn
  port = var.port_tomcat
  protocol = var.b_protocol
  
  default_action {
    type = var.lis_default_action
    target_group_arn = aws_lb_target_group.A4_tomcat_nlbtg.arn
  }
}