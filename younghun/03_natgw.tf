# resource "aws_eip" "sdkim_eip_ng" {
#   vpc = true
# }

# resource "aws_nat_gateway" "sdkim_ng" {
#   allocation_id = aws_eip.sdkim_eip_ng.id
#   subnet_id     = aws_subnet.sdkim_pub[0].id
#   tags = {
#     "Name" = "${var.name}-ng"
#   }
#   depends_on = [
#     aws_internet_gateway.sdkim_ig
#   ]
# }

# resource "aws_route_table" "sdkim_ngrt" {
#   vpc_id = aws_vpc.sdkim_vpc.id

#   route {
#     cidr_block = var.cidr_route
#     gateway_id = aws_nat_gateway.sdkim_ng.id
#   }

#   tags = {
#     "Name" = "${var.name}-ngrt"
#   }
# }

# resource "aws_route_table_association" "sdkim_ngass" {
#   count          = length(var.cidr_private)
#   subnet_id      = aws_subnet.sdkim_pri[count.index].id
#   route_table_id = aws_route_table.sdkim_ngrt.id
# }