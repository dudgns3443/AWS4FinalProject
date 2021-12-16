# Golden-Image Security-Group
resource "aws_security_group" "a4_gi_sg" {
  vpc_id = aws_vpc.a4_vpc_web.id
  name = "Golden-Image security group"
  description = "SSH, HTTP, 8100"
  tags = { "Name" = "gi-sg"}
}

#Golden-Image Security-Group-Rule for SSH
resource "aws_security_group_rule" "a4_ssh_gi" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_gi_sg.id
}

# #Golden-Image Security-Group-Rule for HTTP
resource "aws_security_group_rule" "a4_http_gi" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_gi_sg.id
}

#Golden-Image Security-Group-Rule for Tomcat
resource "aws_security_group_rule" "a4_tomcat_gi" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_gi_sg.id
}

#Golden-Image Security-Gruop-Rule egress
resource "aws_security_group_rule" "a4_egress_gi" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_gi_sg.id
}
