#VPC WAS
resource "aws_vpc" "a4_vpc_was" {
  cidr_block = "10.20.0.0/16"  
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.name}-vpc-was"
  }
}

# VPC-Was Public Subnet
resource "aws_subnet" "a4_pubwas" {
  count = length(var.pub_cidr_was)
  vpc_id            = aws_vpc.a4_vpc_was.id
  cidr_block        = var.pub_cidr_was[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pubwas-${var.az[count.index]}"
  }
}

# VPC-Was Was Subnet
resource "aws_subnet" "a4_priwas" {
  count = length(var.pri_cidr_was)
  vpc_id            = aws_vpc.a4_vpc_was.id
  cidr_block        = var.pri_cidr_was[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-priwas-${var.az[count.index]}"
  }
}

# VPC-Was DB Subnet
resource "aws_subnet" "a4_pridb" {
  count = length(var.db_cidr)
  vpc_id            = aws_vpc.a4_vpc_was.id
  cidr_block        = var.db_cidr[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb-${var.az[count.index]}"
  }
}