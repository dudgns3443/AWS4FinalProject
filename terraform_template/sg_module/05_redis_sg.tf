
#Redis Security-Group
resource "aws_security_group" "redis_sg" {
  vpc_id = data.terraform_remote_state.network.outputs.a4_vpc_was_id
  name = "Redis security group"
  description = "redis-6379"
  tags = { "Name" = "redis-sg"}
}

#Redis Security-Group-Rule for Redis
resource "aws_security_group_rule" "redis_rule" {
  type = var.rule_type[0]
  from_port = var.port_redis
  to_port = var.port_redis
  protocol = var.protocol
  source_security_group_id = aws_security_group.a4_was_sg.id
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
