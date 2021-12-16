# VPC-Web IGW
resource "aws_internet_gateway" "a4_ig_web" {
  vpc_id = aws_vpc.a4_vpc_web.id

  tags = {
    "Name" = "a4-ig-web"
  }
}
# VPC-Was IGW
resource "aws_internet_gateway" "a4_ig_was" {
  vpc_id = aws_vpc.a4_vpc_was.id

  tags = {
    "Name" = "a4-ig-was"
  }
}

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

# was public route table
resource "aws_route_table" "a4_rt_pubwas" {
  vpc_id = aws_vpc.a4_vpc_was.id

  route {
    cidr_block = var.route_cidr_global
    gateway_id = aws_internet_gateway.a4_ig_was.id
  }
  
  tags = {
    "Name" = "a4-rt-pubwas"
  }
}

resource "aws_route_table_association" "a4_rtas_pubwas" {
  count = length(var.pub_cidr_was)
  subnet_id      = aws_subnet.a4_pubwas[count.index].id
  route_table_id = aws_route_table.a4_rt_pubwas.id
}