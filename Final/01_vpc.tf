resource "aws_vpc" "A4_vpc_web" {
  cidr_block = "10.10.0.0/16"  
  enable_dns_hostnames = true
}

resource "aws_vpc" "A4_vpc_was" {
  cidr_block = "10.20.0.0/16"  
  enable_dns_hostnames = true
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = aws_vpc.A4_vpc_web.id
  vpc_id        = aws_vpc.A4_vpc_was.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between web and was"
  }
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

### subnet
resource "aws_subnet" "A4_pub" {
  count = length(var.pub_cidr)
  vpc_id            = aws_vpc.A4_vpc_web.id
  cidr_block        = var.pub_cidr[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.az[count.index]}"
  }
}

resource "aws_subnet" "A4_priweb" {
  count = length(var.pri_cidr_web)
  vpc_id            = aws_vpc.A4_vpc_web.id
  cidr_block        = var.pri_cidr_web[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.az[count.index]}"
  }
}

resource "aws_subnet" "A4_priwas" {
  count = length(var.pri_cidr_was)
  vpc_id            = aws_vpc.A4_vpc_was.id
  cidr_block        = var.pri_cidr_was[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.az[count.index]}"
  }
}

resource "aws_subnet" "A4_pridb" {
  count = length(var.db_cidr)
  vpc_id            = aws_vpc.A4_vpc_was.id
  cidr_block        = var.db_cidr[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.az[count.index]}"
  }
}