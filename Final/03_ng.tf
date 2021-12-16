# VPC-Web natgateway용 EIP
resource "aws_eip" "a4_eip_ng_web" {
  vpc = true
  tags = {
    "Name" = "a4-ng-web"
  }
}

# VPC-Was natgateway용 EIP
resource "aws_eip" "a4_eip_ng_was" {
  vpc = true
  tags = {
    "Name" = "a4-ng-was"
  }
}

# VPC-Web natgateway
resource "aws_nat_gateway" "a4_ng_web" {
  allocation_id = aws_eip.a4_eip_ng_web.id
  subnet_id     = aws_subnet.a4_pub[0].id
  tags = {
    "Name" = "${var.name}-ng-web"
  }
  depends_on = [
    aws_internet_gateway.a4_ig_web
  ]
}

# VPC-Was natgateway
resource "aws_nat_gateway" "a4_ng_was" {
  allocation_id = aws_eip.a4_eip_ng_was.id
  subnet_id     = aws_subnet.a4_pubwas[0].id
  tags = {
    "Name" = "${var.name}-ng-was"
  }
  depends_on = [
    aws_internet_gateway.a4_ig_was
  ]
}

# VPC-web private route table
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


# VPC-Was private route table
resource "aws_route_table" "a4_ngrt_was" {
  vpc_id = aws_vpc.a4_vpc_was.id
  route {
    cidr_block = var.vpc_cidr_web
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_nat_gateway.a4_ng_was.id
  }

  tags = {
    "Name" = "${var.name}-ngrt-was"
  }
}

resource "aws_route_table_association" "a4_ngass_was" {
  count          = length(var.pri_cidr_was)
  subnet_id      = aws_subnet.a4_priwas[count.index].id
  route_table_id = aws_route_table.a4_ngrt_was.id
}

