#VPC Peering Web-Was
resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = aws_vpc.a4_vpc_web.id
  vpc_id        = aws_vpc.a4_vpc_was.id
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