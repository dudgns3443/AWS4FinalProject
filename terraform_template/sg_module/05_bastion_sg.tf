#Bastion Security-Group
resource "aws_security_group" "a4_bastion_sg" {
  vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_web_id
  name = "bastion security group"
  description = "SSH, HTTP, HTTPS"
  tags = { "Name" = "bastion-sg"}
}

#bastion Security-Group-Rule for SSH
resource "aws_security_group_rule" "ssh_bastion" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_bastion_sg.id
}

#bastion Security-Group-Rule for HTTP
resource "aws_security_group_rule" "http_bastion" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_bastion_sg.id
}

#bastion Security-Group-Rule for HTTPS
resource "aws_security_group_rule" "https_bastion" {
  type = var.rule_type[0]
  from_port = var.port_https
  to_port = var.port_https
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_bastion_sg.id
}

#bastion Security-Group-Rule egress
resource "aws_security_group_rule" "egress_bastion" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_bastion_sg.id
}