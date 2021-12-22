#Web-Server Security-Group
resource "aws_security_group" "a4_web_sg" {
  vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_web_id
  name = "Web-server security group"
  description = "SSH, HTTP, HTTPS, EFS-2049"
  tags = { "Name" = "web-sg"}
}

#Web-Server Security-Group-Rule for SSH
resource "aws_security_group_rule" "ssh-web" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  source_security_group_id = aws_security_group.a4_bastion_sg.id
  security_group_id = aws_security_group.a4_web_sg.id
}

#Web-Server Security-Group-Rule for HTTP
resource "aws_security_group_rule" "http-web" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  source_security_group_id = aws_security_group.a4_alb_sg.id
  security_group_id = aws_security_group.a4_web_sg.id
}

#Web-Server Security-Group-Rule for HTTPS
resource "aws_security_group_rule" "https-web" {
  type = var.rule_type[0]
  from_port = var.port_https
  to_port = var.port_https
  protocol = var.protocol
  source_security_group_id = aws_security_group.a4_alb_sg.id
  security_group_id = aws_security_group.a4_web_sg.id
}

#Web-Server Security-Group-Rule for EFS
resource "aws_security_group_rule" "efs-web" {
  type = var.rule_type[0]
  from_port = var.port_efs
  to_port = var.port_efs
  protocol = var.protocol
  source_security_group_id = aws_security_group.a4_efs_sg.id
  security_group_id = aws_security_group.a4_web_sg.id
}

resource "aws_security_group_rule" "tomcat_web" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_web_sg.id
}

#Web-Server Security-Group-Rule egress
resource "aws_security_group_rule" "egress_web" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_web_sg.id
}