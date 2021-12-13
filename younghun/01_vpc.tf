provider "aws"{
    region = var.region
    
}

resource "aws_vpc" "yhkim_vpc_web" {
  cidr_block = "10.2.0.0/16"  
}

resource "aws_vpc" "yhkim_vpc_was" {
  cidr_block = "10.2.0.0/16"  
}


resource "aws_subnet" "yh_pub" {
  count = length(var.pub_cidr)
  vpc_id            = aws_vpc.yhkim_vpc.id
  cidr_block        = var.pub_cidr[count.index]
  availability_zone = "${var.seoul}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.az[count.index]}"
  }
}

resource "aws_subnet" "yh_pri" {
  count = length(var.pri_cidr)
  vpc_id            = aws_vpc.yhkim_vpc.id
  cidr_block        = var.pri_cidr[count.index]
  availability_zone = "${var.seoul}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.az[count.index]}"
  }
}

resource "aws_subnet" "yh_priwas" {
  count = length(var.pri_cidr)
  vpc_id            = aws_vpc.yhkim_vpc.id
  cidr_block        = var.pri_cidr[count.index]
  availability_zone = "${var.seoul}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.az[count.index]}"
  }
}

resource "aws_subnet" "yh_pridb" {
  count = length(var.db_cidr)
  vpc_id            = aws_vpc.yhkim_vpc.id
  cidr_block        = var.db_cidr[count.index]
  availability_zone = "${var.seoul}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.az[count.index]}"
  }
}

# resource "aws_instance" "web" {
#     ami             = "ami-003ef1c0e2776ea27"
#     instance_type   = "t2.micro"
#     availability_zone = "ap-northeast-2a"
#     tags = {
#         "Name" = "web-1"
#     }
#     key_name = "lab7key"
#     user_data = file("userdata.sh")
# }

# output "public_ip" {
#   value       = aws_instance.web.public_ip
# #   sensitive   = true
# #   description = "description"
# #   depends_on  = []
# }
