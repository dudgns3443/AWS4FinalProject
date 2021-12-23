output "a4_vpc_web_id" {
  value = aws_vpc.a4_vpc_web.id
}
output "a4_vpc_was_id" {
  value = aws_vpc.a4_vpc_was.id
}
output "a4_sub_pub_web" {
  value = aws_subnet.a4_pub
}
output "a4_sub_pri_web" {
  value = aws_subnet.a4_priweb
}
output "a4_sub_pub_was" {
  value = aws_subnet.a4_pubwas
}
output "a4_sub_pri_was" {
  value = aws_subnet.a4_priwas
}
output "a4_sub_pri_db" {
  value = aws_subnet.a4_pridb
}