# was public route table
resource "aws_route_table" "a4_rt_pubwas" {
  vpc_id = aws_vpc.a4_vpc_was.id

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_internet_gateway.a4_ig_was.id
  }
  
  tags = {
    "Name" = "${var.name}-rt-pubwas"
  }
}

resource "aws_route_table_association" "a4_rtas_pubwas" {
  count = length(var.pub_cidr_was)
  subnet_id      = aws_subnet.a4_pubwas[count.index].id
  route_table_id = aws_route_table.a4_rt_pubwas.id
}

# was private route table
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

# resource "aws_route_table" "a4_dbrt" {
#   vpc_id = aws_vpc.a4_vpc_was.id
#   route {
#     cidr_block = var.vpc_cidr_web
#     vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
#   }

#   tags = {
#     "Name" = "${var.name}-dbrt"
#   }
# }

# resource "aws_route_table_association" "a4_db_was" {
#   count          = length(var.pri_cidr_was)
#   subnet_id      = aws_subnet.a4_pridb[count.index].id
#   route_table_id = aws_route_table.a4_dbrt.id
# }
