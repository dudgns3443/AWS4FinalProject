#VPC-Was NLB
resource "aws_lb" "a4_nlb" {
  name = "${var.name}-nlb"
  internal = true
  load_balancer_type = var.lb_type[1]
  subnets = [aws_subnet.a4_priwas[0].id,aws_subnet.a4_priwas[1].id]
  tags = {
    "Name" = "${var.name}-nlb"
  }
}

#VPC-Was NLB Target Group 
resource "aws_lb_target_group" "a4_tomcat_nlbtg" {
  name = "a4-tomcat-nlbtg"
  port = var.port_tomcat
  protocol = var.b_protocol
  vpc_id = aws_vpc.a4_vpc_was.id
  target_type = var.target_type
}

#VPC-Was NLB listener
resource "aws_lb_listener" "a4_tomcat_nlblis" {
  load_balancer_arn = aws_lb.a4_nlb.arn
  port = var.port_tomcat
  protocol = var.b_protocol
  
  default_action {
    type = var.lis_default_action
    target_group_arn = aws_lb_target_group.a4_tomcat_nlbtg.arn
  }
}