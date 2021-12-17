#ALB Security-Group
resource "aws_security_group" "a4_alb_sg" {
  vpc_id = data.terraform_remote_state.network.a4_vpc_web_id
  name = "ALB security group"
  description = "HTTP, HTTPS"
  tags = { "Name" = "alb-sg"}
}

#ALB Security-Group-Rule for HTTP
resource "aws_security_group_rule" "http_alb" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_alb_sg.id
}

#ALB Security-Group-Rule for HTTPS
resource "aws_security_group_rule" "https_alb" {
  type = var.rule_type[0]
  from_port = var.port_https
  to_port = var.port_https
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_alb_sg.id
}

#ALB Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_alb" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_alb_sg.id
}