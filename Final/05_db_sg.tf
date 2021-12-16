#Database Security-Group
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.a4_vpc_was.id
  name = "Database security group"
  description = "mysql"
  tags = { "Name" = "db-sg"}
}

#DB-Server Security-Group-Rule for mysql
resource "aws_security_group_rule" "db_sgr" {
  type = var.rule_type[0]
  from_port = var.port_mysql
  to_port = var.port_mysql
  protocol = var.protocol
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id = aws_security_group.db_sg.id
}

#DB-Server Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_db" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.db_sg.id
}