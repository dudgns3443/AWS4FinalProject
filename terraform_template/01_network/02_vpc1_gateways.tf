# vpc1 natgateway용 EIP
resource "aws_eip" "a4_eip_ng_web" {
  vpc = true
  tags = {
    "Name" = "${var.name}-ng-web"
  }
}

# VPC-Web IGW
resource "aws_internet_gateway" "a4_ig_web" {
  vpc_id = aws_vpc.a4_vpc_web.id

  tags = {
    "Name" = "${var.name}-ig-web"
  }
}

# vpc1 natgateway
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
