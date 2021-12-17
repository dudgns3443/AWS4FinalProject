#Was-Server Security-Group
resource "aws_security_group" "a4_was_sg" {
  vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_was_id
  name = "Was-server security group"
  description = "SSH, 8100"
  tags = { "Name" = "was-sg"}
}

#Was-Server Security-Group-Rule for SSH
resource "aws_security_group_rule" "ssh-was" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  source_security_group_id = aws_security_group.a4_bastion_sg.id
  security_group_id = aws_security_group.a4_was_sg.id
}

#Was-Server Security-Group-Rule for tomcat
resource "aws_security_group_rule" "tomcat_was1" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.pri_cidr_was[0]]
  security_group_id = aws_security_group.a4_was_sg.id
}

#Was-Server Security-Group-Rule for tomcat
resource "aws_security_group_rule" "tomcat_was2" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.pri_cidr_was[1]]
  security_group_id = aws_security_group.a4_was_sg.id
}

#Was-Server Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_was" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.a4_was_sg.id
}