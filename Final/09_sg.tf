#Bastion Security-Group
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.A4_vpc_web.id
  name = "bastion security group"
  description = "SSH, HTTP, HTTPS"
  tags = { "Name" = "bastion-sg"}
}

#Web-Server Security-Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.A4_vpc_web.id
  name = "Web-server security group"
  description = "SSH, HTTP, HTTPS, EFS-2049"
  tags = { "Name" = "web-sg"}
}

#Was-Server Security-Group
resource "aws_security_group" "was_sg" {
  vpc_id = aws_vpc.A4_vpc_was.id
  name = "Was-server security group"
  description = "SSH, 8100"
  tags = { "Name" = "was-sg"}
}

#Database Security-Group
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.A4_vpc_was.id
  name = "Database security group"
  description = "mysql"
  tags = { "Name" = "db-sg"}
}

#ALB Security-Group
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.A4_vpc_web.id
  name = "ALB security group"
  description = "HTTP, HTTPS"
  tags = { "Name" = "alb-sg"}
}

#EFS Security-Group
resource "aws_security_group" "efs_sg" {
  vpc_id = aws_vpc.A4_vpc_web.id
  name = "EFS security group"
  description = "EFS-2049"
  tags = { "Name" = "efs-sg"}
}

#Redis Security-Group
resource "aws_security_group" "redis_sg" {
  vpc_id = aws_vpc.A4_vpc_was.id
  name = "Redis security group"
  description = "redis-6379"
  tags = { "Name" = "redis-sg"}
}

#bastion Security-Group-Rule for SSH
resource "aws_security_group_rule" "ssh_bastion" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.bastion_sg.id
}

#bastion Security-Group-Rule for HTTP
resource "aws_security_group_rule" "http_bastion" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.bastion_sg.id
}

#bastion Security-Group-Rule for HTTPS
resource "aws_security_group_rule" "https_bastion" {
  type = var.rule_type[0]
  from_port = var.port_https
  to_port = var.port_https
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.bastion_sg.id
}

#bastion Security-Group-Rule egress
resource "aws_security_group_rule" "egress_bastion" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.bastion_sg.id
}

#Web-Server Security-Group-Rule for SSH
resource "aws_security_group_rule" "ssh-web" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id = aws_security_group.web_sg.id
}

#Web-Server Security-Group-Rule for HTTP
resource "aws_security_group_rule" "http-web" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id = aws_security_group.web_sg.id
}

#Web-Server Security-Group-Rule for HTTPS
resource "aws_security_group_rule" "https-web" {
  type = var.rule_type[0]
  from_port = var.port_https
  to_port = var.port_https
  protocol = var.protocol
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id = aws_security_group.web_sg.id
}

#Web-Server Security-Group-Rule for EFS
resource "aws_security_group_rule" "efs-web" {
  type = var.rule_type[0]
  from_port = var.port_efs
  to_port = var.port_efs
  protocol = var.protocol
  source_security_group_id = aws_security_group.efs_sg.id
  security_group_id = aws_security_group.web_sg.id
}

#Web-Server Security-Group-Rule egress
resource "aws_security_group_rule" "egress_web" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.web_sg.id
}

#Was-Server Security-Group-Rule for SSH
resource "aws_security_group_rule" "ssh-was" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id = aws_security_group.was_sg.id
}

#Was-Server Security-Group-Rule for tomcat
resource "aws_security_group_rule" "tomcat_was1" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.pri_cidr_was[0]]
  security_group_id = aws_security_group.was_sg.id
}

#Was-Server Security-Group-Rule for tomcat
resource "aws_security_group_rule" "tomcat_was2" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.pri_cidr_was[1]]
  security_group_id = aws_security_group.was_sg.id
}

#Was-Server Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_was" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.was_sg.id
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

#ALB Security-Group-Rule for HTTP
resource "aws_security_group_rule" "http_alb" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.alb_sg.id
}

#ALB Security-Group-Rule for HTTPS
resource "aws_security_group_rule" "https_alb" {
  type = var.rule_type[0]
  from_port = var.port_https
  to_port = var.port_https
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.alb_sg.id
}

#ALB Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_alb" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.alb_sg.id
}

#EFS Security-Group-Rule for EFS
resource "aws_security_group_rule" "efs_rule" {
  type = var.rule_type[0]
  from_port = var.port_efs
  to_port = var.port_efs
  protocol = var.protocol
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id = aws_security_group.efs_sg.id
}

#EFS Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_efs" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.efs_sg.id
}

#Redis Security-Group-Rule for Redis
resource "aws_security_group_rule" "redis_rule" {
  type = var.rule_type[0]
  from_port = var.port_redis
  to_port = var.port_redis
  protocol = var.protocol
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id = aws_security_group.redis_sg.id
}

#Redis Security-Gruop-Rule egress
resource "aws_security_group_rule" "egress_redis" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.redis_sg.id
}

#Golden-Image Security-Group-Rule for SSH
resource "aws_security_group_rule" "A4_ssh_gi" {
  type = var.rule_type[0]
  from_port = var.port_ssh
  to_port = var.port_ssh
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.A4_gi_sg.id
}

# #Golden-Image Security-Group-Rule for HTTP
resource "aws_security_group_rule" "A4_http_gi" {
  type = var.rule_type[0]
  from_port = var.port_http
  to_port = var.port_http
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.A4_gi_sg.id
}

#Golden-Image Security-Group-Rule for Tomcat
resource "aws_security_group_rule" "A4_tomcat_gi" {
  type = var.rule_type[0]
  from_port = var.port_tomcat
  to_port = var.port_tomcat
  protocol = var.protocol
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.A4_gi_sg.id
}

#Golden-Image Security-Gruop-Rule egress
resource "aws_security_group_rule" "A4_egress_gi" {
  type = var.rule_type[1]
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.route_cidr_global]
  security_group_id = aws_security_group.A4_gi_sg.id
}

# 필요한 사람만 쓰세요
# default ami용 이미지 파일
# Golden-Image Security-Group
resource "aws_security_group" "A4_gi_sg" {
  vpc_id = aws_vpc.A4_vpc_web.id
  name = "Golden-Image security group"
  description = "SSH, HTTP, 8100"
  tags = { "Name" = "gi-sg"}
}