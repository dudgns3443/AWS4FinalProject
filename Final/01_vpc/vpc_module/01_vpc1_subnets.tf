#VPC WEB
resource "aws_vpc" "a4_vpc_web" {
  cidr_block = "10.10.0.0/16"  
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.name}-vpc-web"
  }
}

### subnet
# VPC-Web Public Subnet
resource "aws_subnet" "a4_pub" {
  count = length(var.pub_cidr)
  vpc_id            = aws_vpc.a4_vpc_web.id
  cidr_block        = var.pub_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pubweb-${var.az[count.index]}"
  }
}

# VPC-Web Web Subnet
resource "aws_subnet" "a4_priweb" {
  count = length(var.pri_cidr_web)
  vpc_id            = aws_vpc.a4_vpc_web.id
  cidr_block        = var.pri_cidr_web[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-priweb-${var.az[count.index]}"
  }
}

output 'subnet_id' {
  value = aws_subnet.a4_priweb.id
}