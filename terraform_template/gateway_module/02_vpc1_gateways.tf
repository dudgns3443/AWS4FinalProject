# # vpc1 natgateway용 EIP
# resource "aws_eip" "a4_eip_ng_web" {
#   vpc = true
#   tags = {
#     "Name" = "a4-ng-web"
#   }
# }

# # VPC-Web IGW
# resource "aws_internet_gateway" "a4_ig_web" {
#   vpc_id =  data.terraform_remote_state.vpc.

#   tags = {
#     "Name" = "a4-ig-web"
#   }
# }

# # vpc1 natgateway
# resource "aws_nat_gateway" "a4_ng_web" {
#   allocation_id = aws_eip.a4_eip_ng_web.id
#   subnet_id     = aws_subnet.a4_pub[0].id
#   tags = {
#     "Name" = "${var.name}-ng-web"
#   }
#   depends_on = [
#     aws_internet_gateway.a4_ig_web
#   ]
# }
