# vpc1 IGW
resource "aws_internet_gateway" "A4_ig" {
  vpc_id = aws_vpc.A4_vpc_web.id

  tags = {
    "Name" = "A4-ig"
  }
}
# vpc2 IGW
resource "aws_internet_gateway" "A4_ig_02" {
  vpc_id = aws_vpc.A4_vpc_was.id

  tags = {
    "Name" = "A4-ig-02"
  }
}

# web public route table
resource "aws_route_table" "A4_rf" {
  vpc_id = aws_vpc.A4_vpc_web.id
  
  route {
    cidr_block = var.vpc_cidr_was
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_internet_gateway.A4_ig.id
  }
  
  tags = {
    "Name" = "A4-rt"
  }
}

resource "aws_route_table_association" "A4_rtas" {
  count = length(var.pub_cidr)
  subnet_id      = aws_subnet.A4_pub[count.index].id
  route_table_id = aws_route_table.A4_rf.id
}

# was public route table
resource "aws_route_table" "A4_rf_02" {
  vpc_id = aws_vpc.A4_vpc_was.id

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_internet_gateway.A4_ig_02.id
  }
  
  tags = {
    "Name" = "A4-rt"
  }
}

resource "aws_route_table_association" "A4_rtas_02" {
  count = length(var.pub_cidr_was)
  subnet_id      = aws_subnet.A4_pubwas[count.index].id
  route_table_id = aws_route_table.A4_rf_02.id
}