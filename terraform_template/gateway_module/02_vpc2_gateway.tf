
# # vpc2 natgateway용 EIP
# resource "aws_eip" "a4_eip_ng_was" {
#   vpc = true
#   tags = {
#     "Name" = "a4-ng-was"
#   }
# }
# # VPC-Was IGW
# resource "aws_internet_gateway" "a4_ig_was" {
#   vpc_id = aws_vpc.a4_vpc_was.id

#   tags = {
#     "Name" = "a4-ig-was"
#   }
# }

# # vpc2 natgateway
# resource "aws_nat_gateway" "a4_ng_was" {
#   allocation_id = aws_eip.a4_eip_ng_was.id
#   subnet_id     = aws_subnet.a4_pubwas[0].id
#   tags = {
#     "Name" = "${var.name}-ng-was"
#   }
#   depends_on = [
#     aws_internet_gateway.a4_ig_was
#   ]
# }