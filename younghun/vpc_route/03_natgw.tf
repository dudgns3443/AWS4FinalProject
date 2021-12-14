resource "aws_eip" "yhkim_eip_ng" {
  vpc = true
}

resource "aws_nat_gateway" "yhkim_ng" {
  allocation_id = aws_eip.yhkim_eip_ng.id
  subnet_id     = aws_subnet.yh_pub[0].id
  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [
    aws_internet_gateway.yhkim_ig
  ]
}

resource "aws_route_table" "yhkim_ngrt_web" {
  vpc_id = aws_vpc.yhkim_vpc_web.id
  route {
    cidr_block = var.vpc_cidr_was
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_nat_gateway.yhkim_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}



resource "aws_route_table_association" "yhkim_ngass" {
  count          = length(var.cidr_private)
  subnet_id      = aws_subnet.yh_priweb[count.index].id
  route_table_id = aws_route_table.yhkim_ngrt.id
}

resource "aws_route_table" "yhkim_ngrt" {
  vpc_id = aws_vpc.yhkim_vpc_web.id
  route {
    cidr_block = var.vpc_cidr_web
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_nat_gateway.yhkim_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

resource "aws_route_table_association" "yhkim_ngass" {
  count          = length(var.cidr_private)
  subnet_id      = aws_subnet.yh_priwas[count.index].id
  route_table_id = aws_route_table.yhkim_ngrt.id
}