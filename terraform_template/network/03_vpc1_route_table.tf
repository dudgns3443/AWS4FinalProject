# web public route table
resource "aws_route_table" "a4_rt_pubweb" {
  vpc_id = aws_vpc.a4_vpc_web.id
  
  route {
    cidr_block = var.vpc_cidr_was
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_internet_gateway.a4_ig_web.id
  }
  
  tags = {
    "Name" = "a4-rt-pubweb"
  }
}

resource "aws_route_table_association" "a4_rtas_pubweb" {
  count = length(var.pub_cidr)
  subnet_id      = aws_subnet.a4_pub[count.index].id
  route_table_id = aws_route_table.a4_rt_pubweb.id
}

# web private route table
resource "aws_route_table" "a4_ngrt_web" {
  vpc_id = aws_vpc.a4_vpc_web.id
  route {
    cidr_block = var.vpc_cidr_was

    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_nat_gateway.a4_ng_web.id
  }

  tags = {
    "Name" = "${var.name}-ngrt-web"
  }
}



resource "aws_route_table_association" "a4_ngass-web" {
  count          = length(var.pri_cidr_web)
  subnet_id      = aws_subnet.a4_priweb[count.index].id
  route_table_id = aws_route_table.a4_ngrt_web.id
}
