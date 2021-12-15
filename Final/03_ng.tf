# public-a에 있는 ng
resource "aws_eip" "A4_eip_ng" {
  vpc = true
}

resource "aws_nat_gateway" "A4_ng" {
  allocation_id = aws_eip.A4_eip_ng.id
  subnet_id     = aws_subnet.A4_pub[0].id
  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [
    aws_internet_gateway.A4_ig
  ]
}

# peering web -> was
resource "aws_route_table" "A4_ngrt_web" {
  vpc_id = aws_vpc.A4_vpc_web.id
  route {
    cidr_block = var.vpc_cidr_was

    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_nat_gateway.A4_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}



resource "aws_route_table_association" "A4_ngass" {
  count          = length(var.pri_cidr_web)
  subnet_id      = aws_subnet.A4_priweb[count.index].id
  route_table_id = aws_route_table.A4_ngrt_web.id
}

resource "aws_route_table" "A4_ngrt_was" {
  vpc_id = aws_vpc.A4_vpc_was.id
  route {
    cidr_block = var.vpc_cidr_web
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  # route {
  #   cidr_block = var.route_cidr_global
  #   gateway_id = aws_nat_gateway.A4_ng.id
  # }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

resource "aws_route_table_association" "A4_ngass_was" {
  count          = length(var.pri_cidr_was)
  subnet_id      = aws_subnet.A4_priwas[count.index].id
  route_table_id = aws_route_table.A4_ngrt_was.id
}

# pri-was-a
resource "aws_eip" "A4_eip_ng_02" {
  vpc = true
}

resource "aws_nat_gateway" "A4_ng_02" {
  allocation_id = aws_eip.A4_eip_ng_02.id
  subnet_id     = aws_subnet.A4_priwas[0].id
  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [
    aws_internet_gateway.A4_ig
  ]
}